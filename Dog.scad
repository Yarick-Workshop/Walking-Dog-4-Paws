
/* [General] */
expectedLength = 112;
renderingType = "Preview";//["Preview", "Producing"]

/* [Screws] */
screwHoleDiameter = 3;
screwHeaderDiameter = 6;
screwHeaderDepth = 2.4;
screwNutDiameter = 6.5;
screwNutDepth = 2.4;

/* [Debug] */
showDebugFigures = false;


/* [Wheels] */
showWheels = true;
wheelWidth = 21;
wheelShaftDiameter = 5;
wheelSpacerDiameter = 40;
wheelSpacerOffset = 0.6;
wheelColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Sides] */
showLeftSide = true;
showRightSide = true;
sideWidth = 25;
sideColor = "Brown";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Medium] */
showMedium = true;
mediumWidth = 55;
mediumColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]


/* [Hidden] */
sideShift = 15.01;
wheelRealDiameter = 212;
sideRealLength = 559.026;
sideRealHeight = 329.776;
delta = 0.05;
wheelPlaceDiameter = 235;

sideMountingHoleCoords = [[165, 35], [-48.3, -25], [-215, 80], [-230, 15]];

wheelCoords = [[-159.7, -115.33], [64.25, -111.8]];

// calculations
scaleFactor = expectedLength / sideRealLength;
wheelSpacerHeight = (mediumWidth - wheelWidth - 2 * wheelSpacerOffset / scaleFactor) * 0.5;

// debug information
echo();echo();
/*echo("Side shift: ", sideShift);
echo();*/
echo("Scale factor: ", scaleFactor);
echo();
echo("Result wheel diameter ", wheelRealDiameter * scaleFactor);
echo("Result wheel spacer wall thickness", (wheelSpacerDiameter * scaleFactor - wheelShaftDiameter) / 2);
echo();
echo("Result side length ", sideRealLength * scaleFactor);
echo("Result side heigh ", sideRealHeight * scaleFactor);
echo("Result side width: ", sideWidth * scaleFactor);
echo();
echo("Result medium width: ", mediumWidth * scaleFactor);
echo();
echo("Result total width: ", (2 * sideWidth + mediumWidth) * scaleFactor);
echo();echo();


scale([scaleFactor, scaleFactor, scaleFactor])
{
    if (renderingType == "Producing")
        dog_for_producing();
    else
        dog_for_preview();
}

module dog_for_producing()
{
    translate([0, 0, sideWidth * 0.5])
        rotate([0, 180, 180])
            dog_left_side();
    
    translate([0, sideRealHeight * 0.95, sideWidth * 0.5])
        dog_right_side();
    
    translate([+sideRealLength * 0.6, sideRealHeight * 0.3, mediumWidth * 0.5])
        rotate([0, 0, 270]) 
            dog_medium();
    
    translate([0.35 * sideRealLength, sideRealHeight * 0.5, 0])
        dog_wheel_spacer();

    translate([-0.17 * sideRealLength, sideRealHeight * 1.27, wheelWidth * 0.5])
        dog_wheel();
    
    translate([-0.3 * sideRealLength, -sideRealHeight * 0.5, 0]) 
        rotate([0, 0, 90]) 
        	customization_figures();
}

module dog_for_preview()
{
    translate([0, 0, sideRealHeight * 0.65])
	rotate([90,0,0])
	{
	    translate([0, 0, sideWidth * 0.5])
	        dog_left_side();
	    
	    translate([0, 0, sideWidth * 1.5 + mediumWidth])
	        dog_right_side();
	    
	    translate([0, 0, sideWidth + mediumWidth * 0.5])
	        dog_medium();
	    
	    dog_wheels();
    }
}

module dog_medium()
{
    if (showMedium)
    {
        color(mediumColor, 1.0)
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
        mirror([0, 0, 1])
            dog_side("left");
    }
}

module dog_right_side()
{
    if (showRightSide)
    {
        dog_side("right");
    }
}

module dog_side(side)
{
    assert(side=="left" || side == "right", str("Side should be either \"left\" or \"right\" but not \"", side, "\"."));
    
    screwHead = side == "left";
    
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
                    screw_hole_with_groove(sideWidth, screwHead);
                }
            }
            for (wheelCoord = wheelCoords)
            {
                translate([wheelCoord[0], wheelCoord[1], 0])
                    screw_hole_with_groove(sideWidth, screwHead);
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
            dog_wheel_assembled();
    }
}

module dog_wheel_spacer()
{
    color(wheelColor, 1.0)
    difference()
    {
        cylinder(h=wheelSpacerHeight, d = wheelSpacerDiameter, $fn=360);
        translate([0,0, -delta * 0.5])
            cylinder(h=wheelSpacerHeight + delta, d=wheelShaftDiameter / scaleFactor, $fn=360);
    }
}

module dog_wheel_assembled()
{
    color(wheelColor, 1.0)
    if (showWheels)
    {
        dog_wheel();
        
        translate([0, 0, -wheelWidth * 0.5-wheelSpacerHeight])
                dog_wheel_spacer();
    }       
}

module dog_wheel()
{
	color(wheelColor, 1.0)
    if (showWheels)
    {
        translate([0, 0, wheelWidth * 0.5])
            dog_wheel_spacer();
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

module screw_hole_with_groove(height, screwHead)
{
    screw_hole(height);
    
    depth = (screwHead ? screwHeaderDepth : screwNutDepth) / scaleFactor;
    diameter = (screwHead ?  screwHeaderDiameter : screwNutDiameter) / scaleFactor;
    $fn = screwHead ? 360 : 6;

    translate([0, 0, sideWidth * 0.5 - depth])
		cylinder(h = depth + delta, d = diameter);
}

module debug_figure()
{
    cylinder(h = 100, r = 0.5, center = true, $fn=360);
}

module customization_figures()
{
    maxDiameter = max(screwHeaderDiameter, wheelShaftDiameter);
    testCubeWidth = maxDiameter * 2.5 / scaleFactor;

    // screw head
    translate([0, testCubeWidth * 1.1, sideWidth * 0.5]) 
	    difference()
	    {
	        cube([testCubeWidth, testCubeWidth, sideWidth], center=true);
	        screw_hole_with_groove(sideWidth, true);
	    }

    // screw nut
    translate([0, 0, sideWidth * 0.5]) 
	    difference()
	    {
	        cube([testCubeWidth, testCubeWidth, sideWidth], center=true);
	        screw_hole_with_groove(sideWidth, false);
	    }

    // wheel shaft
    translate([0, -testCubeWidth * 1.1, sideWidth * 0.5]) 
	    difference()
	    {
	        cube([testCubeWidth, testCubeWidth, sideWidth], center=true);
	        cylinder(h = sideWidth / scaleFactor, d = wheelShaftDiameter / scaleFactor, center=true, $fn=360);
	    }
}