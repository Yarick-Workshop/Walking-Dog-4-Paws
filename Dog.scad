/* [General] */
expectedLength = 112;
renderingType = "Preview";//["Preview", "Producing"]
rounding = "Off";//["Off", "Cone", "Sphere"]
roundingRadius = 2.5;

/* [Screws] */
screwHoleDiameter = 3.35;
screwHeaderDiameter = 6.2;
screwHeaderDepth = 2.4;
screwNutDiameter = 6.53;
screwNutDepth = 2.4;

/* [Debug] */
showDebugFigures = false;

/* [Wheels] */
showWheels = true;
wheelSpacerHeight = 2.8;
wheelShaftDiameter = 4.7;
wheelSpacerDiameter = 8.0;
wheelSpacerOffset = 0.6;
wheelColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Sides] */
showLeftSide = true;
showRightSide = true;
sideWidth = 5.0;
sideColor = "Brown";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Medium] */
showMedium = true;
mediumWidth = 11.0;
mediumColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Hidden] */
sideShift = 15.01;
wheelRealDiameter = 212;
sideRealLength = 559.026;
sideRealHeight = 329.776;
delta = 0.05;


// calculations
scaleFactor = expectedLength / sideRealLength;
wheelWidth = (mediumWidth -  2 * (wheelSpacerHeight + wheelSpacerOffset));
wheelPlaceDiameter = wheelRealDiameter * scaleFactor * 1.05;

//TODO refactor it, too many repeating of scaleFactor
sideMountingHoleCoords = [[165 * scaleFactor, 35 * scaleFactor], 
    [-48.3 * scaleFactor, -25 * scaleFactor], 
    [-215 * scaleFactor, 80 * scaleFactor], 
    [-230 * scaleFactor, 15 * scaleFactor]];

wheelCoords = [[-159.7 * scaleFactor, -115.33 * scaleFactor],
    [64.25 * scaleFactor, -111.8 * scaleFactor]];

// debug information
echo();echo();
echo("Results: ");
echo("  Scale factor: ", scaleFactor);
echo();
echo("  Wheel: ");
echo("      Diameter: ", wheelRealDiameter * scaleFactor);
echo("      Spacer wall thickness: ", (wheelSpacerDiameter - wheelShaftDiameter) * 0.5);
echo("      Width: ", wheelWidth);
echo();
echo("  Side: ");
echo("      Total length: ", sideRealLength * scaleFactor);
echo("      Total height: ", sideRealHeight * scaleFactor);
echo();
echo("  Others: ");
echo("      Total width: ", 2 * sideWidth + mediumWidth);
echo("      Screw rod length: ", 2 * sideWidth + mediumWidth - screwHeaderDepth);
echo();echo();

rotate([0,0,360*$t])
if (renderingType == "Producing")
    dog_for_producing();
else
    dog_for_preview();


module dog_for_producing()
{
    sideScaledHeigh = sideRealHeight * scaleFactor;
    sideScaledLength = sideRealLength * scaleFactor;

    translate([0, 0, sideWidth * 0.5])
        rotate([0, 180, 180])
            dog_left_side();
    
    translate([0, sideScaledHeigh * 0.95, sideWidth * 0.5])
        dog_right_side();
    
    translate([+sideScaledLength * 0.6, sideScaledHeigh * 0.3, mediumWidth * 0.5])
        rotate([0, 0, 270]) 
            dog_medium();

    if (showWheels)
    {
        translate([0.35 * sideScaledLength, sideScaledHeigh * 0.5, 0])
            dog_wheel_spacer(wheelSpacerHeight);
    }

    translate([-0.17 * sideScaledLength, sideScaledHeigh * 1.7, wheelWidth * 0.5])
        dog_wheel();
    
    translate([-0.3 * sideScaledLength, -sideScaledHeigh * 0.5, 0]) 
        rotate([0, 0, 90]) 
        	customization_figures();
}

module dog_for_preview()
{
    translate([0, 0, sideRealHeight * 0.65 * scaleFactor])
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
                dog_medium_internal();
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

module dog_medium_internal()
{
    if (isRoundingOn())
    {
        minkowski(convexity=20)
        {
            translate([0, 0, -roundingRadius * 0.5]) 
                dog_medium_extrude(_medium_scale_factor = (expectedLength - 2 * roundingRadius) / sideRealLength, 
                    _medium_width = mediumWidth - roundingRadius);
            cylinder(h = roundingRadius, r = roundingRadius, $fn=24);
        }
    }
    else
    {
        dog_medium_extrude(_medium_scale_factor = scaleFactor, 
            _medium_width = mediumWidth);
    }
}

module dog_medium_extrude(_medium_scale_factor, _medium_width)
{
    scale([_medium_scale_factor, _medium_scale_factor, 1]) 
        linear_extrude(height = _medium_width, convexity=20, center = true)
            import(file = "dog_4_scad_medium.svg", $fn=360, center = true);
}

function isRoundingOn() = rounding != "Off" && roundingRadius != 0;

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
        dog_side_internal();
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
        color(undef)
            scale([scaleFactor, scaleFactor, 1])
                translate([0, sideShift, 0])
                    cube([sideRealLength, sideRealHeight, sideWidth * 0.5], center = true);
    }
}

module dog_side_internal()
{
    if (isRoundingOn())
    {
        minkowski(convexity=20) 
        {
            translate([0, 0, -roundingRadius * 0.5]) 
                dog_side_extrude(_side_scale_factor = (expectedLength - 2 * roundingRadius) / sideRealLength, 
                    _side_width = sideWidth - roundingRadius);
            if (rounding == "Cone")
            {
                cylinder(h = roundingRadius, r1 = roundingRadius, r2 = 0, $fn=24);
            }
            else if (rounding == "Sphere")
            {
                difference() 
                {
                    sphere(r = roundingRadius, $fn=24);
                    translate([0, 0, - 0.5 * roundingRadius]) 
                        cube([2 * roundingRadius, 2 * roundingRadius, roundingRadius], center=true);
                }
            }
            else 
            { 
                assert(false, "Only \"Cone\" and \"Sphere\" are supported for rounding!");
            }
        }
    }
    else
    {
        dog_side_extrude(_side_scale_factor = scaleFactor, 
            _side_width = sideWidth);
    }
}

module dog_side_extrude(_side_scale_factor, _side_width)
{
    scale([_side_scale_factor, _side_scale_factor, 1]) 
        translate([0, sideShift, 0])
            linear_extrude(height = _side_width, convexity=20, center = true)
                import(file = "dog_4_scad_side.svg", $fn=360, center = true);
}

module dog_wheels()
{
    for (wheelCoord = wheelCoords)
    {
        translate([wheelCoord[0], wheelCoord[1], sideWidth + mediumWidth * 0.5])
            dog_wheel_assembled();
    }
}

module dog_wheel_spacer(currentHeight)
{
    if (currentHeight != 0)
    {
        color(wheelColor, 1.0)
        difference()
        {
            cylinder(h=currentHeight, d = wheelSpacerDiameter, $fn=360);
            translate([0,0, -delta * 0.5])
                cylinder(h=currentHeight + delta, d=wheelShaftDiameter, $fn=360);
        }
    }
}

module dog_wheel_assembled()
{
    color(wheelColor, 1.0)
    if (showWheels)
    {
        dog_wheel();
        
        translate([0, 0, -wheelWidth * 0.5-wheelSpacerHeight])
                dog_wheel_spacer(wheelSpacerHeight);
    }       
}

module dog_wheel()
{
	color(wheelColor, 1.0)
    if (showWheels)
    {
        dog_wheel_spacer(wheelSpacerHeight + wheelWidth * 0.5);
        difference()
        {
           // rotate([0, 0, - $t * 360 * 6])
                scale([scaleFactor, scaleFactor, 1]) 
                    translate([0.6, -1.1, 0])// centering
                        linear_extrude(height = wheelWidth, convexity=20, center = true) 
                            import(file = "dog_4_scad_wheel.svg", center=true, $fn=360);
            cylinder(h = wheelWidth + delta, d = wheelShaftDiameter, center = true, $fn = 360);
        }

        if (showDebugFigures)
        {
            debug_figure();
            
            //for centering wheels
            scale([scaleFactor, scaleFactor, 1]) 
                cylinder(h=wheelWidth - 0.5, d = wheelRealDiameter, center=true, $fn=360);
        }
    }
}

module screw_hole(height)
{
    cylinder(h = height + delta, d = screwHoleDiameter, center = true, $fn=360);
}

module screw_hole_with_groove(height, screwHead)
{
    screw_hole(height);
    
    depth = (screwHead ? screwHeaderDepth : screwNutDepth);
    diameter = (screwHead ?  screwHeaderDiameter : screwNutDiameter);
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
    $fn = 8;
    maxDiameter = max(screwHeaderDiameter, wheelShaftDiameter);
    testCubeWidth = maxDiameter * 2.5;

    // screw head
    translate([0, testCubeWidth * 1.1, sideWidth * 0.5]) 
	    difference()
	    {
	        cylinder(h = sideWidth, d = testCubeWidth, center=true);
	        screw_hole_with_groove(sideWidth, true);
	    }

    // screw nut
    translate([0, 0, sideWidth * 0.5]) 
	    difference()
	    {
	        cylinder(h = sideWidth, d = testCubeWidth, center=true);
	        screw_hole_with_groove(sideWidth, false);
	    }

    // wheel shaft
    translate([0, -testCubeWidth * 1.1, sideWidth * 0.5]) 
	    difference()
	    {
	        cylinder(h = sideWidth, d = testCubeWidth, center=true);
	        cylinder(h = sideWidth + delta, d = wheelShaftDiameter, center=true, $fn=360);
	    }
}