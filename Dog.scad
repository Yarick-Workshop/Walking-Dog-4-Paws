rounding = 10;

/* [General] */
expectedLength = 150;
screwHoleDiameter = 3;
screwHeaderDiameter = 6;
screwHeaderDepth = 2;

/* [Debug] */
showDebugFigures = false;


/* [Wheels] */
showWheels = true;
wheelWidth = 21;
wheelShaftDiameter = 5;
wheelColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Sides] */
showLeftSide = true;
showRightSide = true;
sideWidth = 17;
sideColor = "Brown";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Medium] */
showMedium = true;
mediumWidth = 45;
mediumColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]


/* [Hidden] */
sideShift = 15.01;
wheelRealDiameter = 212;
sideRealLength = 559.026;
sideRealHeight = 329.776;
delta = 0.01;
wheelPlaceDiameter = 235;

sideMountingHoleCoords = [[165, 35], [-48.3, -25], [-215, 80], [-230, 15]];

wheelCoords = [[-159.7, -115.33], [64.25, -111.8]];

// calculations
scaleFactor = expectedLength / sideRealLength;

// debug information
echo();
echo("Side shift: ", sideShift);
echo("Scale factor: ", scaleFactor);
echo("Real wheel diameter ", wheelRealDiameter);
echo("Real side length ", sideRealLength);
echo("Real side heigh ", sideRealHeight);
echo("Scaled side width: ", sideWidth * scaleFactor);
echo();


//difference()
//translate([$t * 2000, 0, 0])
//translate([0, 0, scaleFactor * sideRealHeight * 0.5])*/
rotate([0, 0, 360 * $t])
translate([0, -1000, 0])
rotate([90,0,0])//s
scale([scaleFactor, scaleFactor, scaleFactor])
{
    dog_left_side();
    
    dog_right_side();
    
    dog_medium();
    
    dog_wheels();
}

module dog_medium()
{
    if (showMedium)
    {
        color(mediumColor, 1.0)
        translate([0, 0, sideWidth + mediumWidth * 0.5])       
            difference()
            {
                linear_extrude(height = mediumWidth, convexity=2, center = true)
                    import(file = "dog_4_scad_medium.svg", $fn=360, center = true);
                union()
                {
                    for(coord = sideMountingHoleCoords)
                    {
                        translate([coord[0], coord[1], 0])
                            screw_hole(mediumWidth);
                    }
                    for (wheelCoord = wheelCoords)
                    {
                        translate([wheelCoord[0], wheelCoord[1], 0])
                                cylinder(h = mediumWidth + delta, d = wheelPlaceDiameter, center=true, $fn = 360);
                    }
                }
            }
    }
}

module dog_left_side()
{
    if (showLeftSide)
    {
        translate([0, 0, sideWidth * 0.5])
            mirror([0, 0, 1])
            dog_side();
    }
}

module dog_right_side()
{
    if (showRightSide)
    {
        translate([0, 0, sideWidth * 1.5 + mediumWidth])
            dog_side();
    }
}

module dog_side()
{
    color(sideColor, 1.0)
    difference()
    {
        translate([0, sideShift, 0])
            linear_extrude(height = sideWidth, convexity=10, center = true)
                import(file = "dog_4_scad_side.svg", $fn=360, center = true);
        union()
        {
            for(coord = sideMountingHoleCoords)
            {
                translate([coord[0], coord[1], 0])
                {
                    screw_hole(sideWidth);
                    
                    translate([0, 0, sideWidth * 0.5 - screwHeaderDepth / scaleFactor])
                        cylinder(h = screwHeaderDepth / scaleFactor + delta, d = screwHeaderDiameter / scaleFactor, $fn = 360);
                }
            }
            for (wheelCoord = wheelCoords)
            {
                translate([wheelCoord[0], wheelCoord[1], 0])
                    cylinder(h = sideWidth * 100 + delta, d = wheelShaftDiameter / scaleFactor, center = true);
            }
        }
    }

    if (showDebugFigures)
    {
        translate([0, sideShift, 0])
            color(undef)
                cube([sideRealLength, sideRealHeight, sideWidth * 0.5], center = true);
    }
}

module dog_wheels()
{
    for (wheelCoord = wheelCoords)
    {
        translate([wheelCoord[0], wheelCoord[1], sideWidth + mediumWidth * 0.5])
            dog_wheel();
    }
}

module dog_wheel()
{
    if (showWheels)
    {
        color(wheelColor, 1.0)
            difference()
            {
                rotate([0, 0, - $t * 360 * 6])
                    translate([0.6, -1.1, 0])// centering
                        linear_extrude(height = wheelWidth, convexity=6, center = true) 
                            import(file = "dog_4_scad_wheel.svg", center=true, $fn=360);
                cylinder(h = wheelWidth + delta, d = wheelShaftDiameter / scaleFactor, center = true, $fn = 360);
            }

        if (showDebugFigures)
        {
            debug_figure();
            
            //for centering wheels 
            //cylinder(h=wheelWidth - 0.5, d = wheelRealDiameter, center=true, $fn=360);
        }
    }
}

module screw_hole(height)
{
    cylinder(h = height + delta, d = screwHoleDiameter / scaleFactor, center = true, $fn=360);
}

module debug_figure()
{
    cylinder(h = 100, r = 0.5, center = true, $fn=360);
}