/* [General] */
expectedLength = 112;
renderingType = "Preview";//["Preview", "Producing", "Demo"]
rounding = "Off";//["Off", "Cone", "Sphere"]
roundingRadius = 3.0;

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
showWheelSpacers = true;
wheelSpacerHeight = 0.8;
wheelSpacerDiameter = 13;
wheelSpacerOffset = 1.0;
wheelInternalSpacerHeight = 8;
wheelInternalSpacerDiameter = 10;
wheelTenonOffset = 0.0;
wheelShaftDiameter = 4.7;
wheelColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Sides] */
showLeftSide = true;
showRightSide = true;
sideWidth = 5.0;
sideColor = "Brown";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]

/* [Medium] */
showMedium = true;
mediumTotalWidth = 25.0;
mediumColor = "White";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]
mediumSideWidth = 8;
mediumSideColor = "Brown";// [Black, Blue, Brown, Chartreuse, Green, Magenta, Orange, Purple, Red, Teal, Violet, White, Yellow]


/* [Hidden] */
sideShift = 15.01;
wheelRealDiameter = 212;
sideRealLength = 559.026;
sideRealHeight = 329.776;
delta = 0.05;


// calculations
scaleFactor = expectedLength / sideRealLength;
wheelPairWidth = (mediumTotalWidth -  2 * (wheelSpacerHeight + wheelSpacerOffset));
wheelWidth = (wheelPairWidth -  wheelInternalSpacerHeight) / 2;
wheelPlaceDiameter = wheelRealDiameter * scaleFactor * 1.05;
totalWidth = 2 * sideWidth + mediumTotalWidth;

function GetSideScaleFactor(rounding, roundingRadius) = 
    isRoundingOn(rounding, roundingRadius) ? 
        (expectedLength - 2 * roundingRadius) / sideRealLength :
        scaleFactor;//TODO generalize it across the file

function GetSideMountingHoleCoords(rounding, roundingRadius) = 
    //TODO refactor it, too many repeating of scaleFactor
    [
        [165 * GetSideScaleFactor(rounding, roundingRadius), 35 * scaleFactor],  // "eye"
        [-48.3 * scaleFactor, -25 * scaleFactor],   // above the paws
        [-215 * GetSideScaleFactor(rounding, roundingRadius), 80 * scaleFactor], // tail #1
        [-230 * GetSideScaleFactor(rounding, roundingRadius), 15 * scaleFactor]];// tail #2

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
echo("      Wheel pair width: ", wheelPairWidth);
echo();
echo("  Side: ");
echo("      Total length: ", sideRealLength * scaleFactor);
echo("      Total height: ", sideRealHeight * scaleFactor);
echo();
echo("  Others: ");
echo("      Total width: ", totalWidth);
echo("      Screw rod length: ", totalWidth - screwHeaderDepth);
echo();echo();


use <Dog-Utils.scad>
use <Dog-Paw-Library.scad>
use <Dog-Medium-Library.scad>


rotate([0,0,360*$t])
if (renderingType == "Producing")
    dog_for_producing();
else if (renderingType == "Preview")
    dog_for_preview(rounding, roundingRadius);
else if (renderingType == "Demo")
{
    stepY = 2.5;

    stepX = 0.2;

    dog_for_preview("Off", roundingRadius);

    translate([expectedLength * stepX, stepY * totalWidth, 0])
        dog_for_preview("Cone", roundingRadius);

    translate([2 * expectedLength * stepX, 2 * stepY * totalWidth, 0])
        dog_for_preview("Sphere", roundingRadius);
}
//TODO  add wrong type handling after "else"


module dog_for_producing()
{
    sideScaledHeigh = sideRealHeight * scaleFactor;
    sideScaledLength = sideRealLength * scaleFactor;

    translate([0, 0, sideWidth * 0.5])
        rotate([0, 180, 180])
            dog_left_side(rounding, roundingRadius);
    
    translate([0, sideScaledHeigh * 1.05, sideWidth * 0.5])
        dog_right_side(rounding, roundingRadius);
    
    if (showMedium)
    {
        translate([sideScaledHeigh * 1.9, sideScaledHeigh * 0.3, 0])
        {
            dog_medium_medium(rounding, roundingRadius);
        
            translate([0, sideScaledHeigh * -0.8, 0])
                dog_medium_side(rounding, roundingRadius);
            
            translate([0, sideScaledHeigh * 0.8, 0])
            dog_medium_side(rounding, roundingRadius);
        }
    }

    color(wheelColor, 1.0) 
    if (showWheels)
    {
        translate([0.4 * sideScaledLength, sideScaledHeigh * 0.5, 0])
        {
            dog_wheel_spacer(height = wheelSpacerHeight,
                            diameter = wheelSpacerDiameter,
                            shaftDiameter = wheelShaftDiameter,
                            delta= delta);

            translate([0, -1 * sideScaledHeigh, 0])
                dog_wheel_spacer(height = wheelSpacerHeight,
                                diameter = wheelSpacerDiameter,
                                shaftDiameter = wheelShaftDiameter,
                                delta= delta);
        }


        translate([-0.17 * sideScaledLength, sideScaledHeigh * 1.9, 0])
            dog_left_wheel();

        translate([0.47 * sideScaledLength, sideScaledHeigh * 1.9, 0])
            dog_right_wheel();
    }
    
    translate([-0.3 * sideScaledLength, -sideScaledHeigh * 0.7, 0]) 
        rotate([0, 0, 90]) 
        	customization_figures();
}

module dog_for_preview(rounding, roundingRadius)
{
    translate([0, 0, sideRealHeight * 0.65 * scaleFactor])
	rotate([90,0,0])
	{
	    translate([0, 0, sideWidth * 0.5])
	        dog_left_side(rounding, roundingRadius);
	    
	    translate([0, 0, sideWidth * 1.5 + mediumTotalWidth])
	        dog_right_side(rounding, roundingRadius);
	    
        if (showMedium)
        {
            translate([0, 0, sideWidth])
            {
                dog_medium_side(rounding, roundingRadius);

                translate([0, 0, mediumSideWidth]) 
                    dog_medium_medium(rounding, roundingRadius);
                
                translate([0, 0, mediumTotalWidth - mediumSideWidth]) 
                    dog_medium_side(rounding, roundingRadius);
            }
        }
	    
	    dog_wheels_assembled();
    }
}

function isRoundingOn(_rounding, _roundingRadius) = _rounding != "Off" && roundingRadius != 0;

module dog_left_side(rounding, roundingRadius)
{
    if (showLeftSide)
    {
        mirror([0, 0, 1])
            dog_side("left", rounding, roundingRadius);
    }
}

module dog_right_side(rounding, roundingRadius)
{
    if (showRightSide)
    {
        dog_side("right", rounding, roundingRadius);
    }
}

module dog_side(side, rounding, roundingRadius)
{
    assert(side=="left" || side == "right", str("Side should be either \"left\" or \"right\" but not \"", side, "\"."));
    
    screwHead = side == "left";
    
    color(sideColor, 1.0)
    difference()
    {
        dog_side_internal(rounding, roundingRadius);
        union()
        {
            for(coord = GetSideMountingHoleCoords(rounding, roundingRadius))
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

module dog_side_internal(rounding, roundingRadius)
{
    if (isRoundingOn(rounding, roundingRadius))
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

module dog_wheels_assembled()
{
    color(wheelColor, 1.0)
    if (showWheels)
    {    
        for (wheelCoord = wheelCoords)
        {
            translate([wheelCoord[0], wheelCoord[1], sideWidth + wheelSpacerOffset])
            {
                if (showWheelSpacers)
                {
                    dog_wheel_spacer(height = wheelSpacerHeight,
                                diameter = wheelSpacerDiameter,
                                shaftDiameter = wheelShaftDiameter,
                                delta = delta);
                }

                translate([0, 0, wheelSpacerHeight])
                {
                    dog_left_wheel();

                    translate([0, 0, 2 * wheelWidth + wheelInternalSpacerHeight]) 
                    {
                        rotate([180, 0, 180 + 45]) 
                            dog_right_wheel();

                        dog_wheel_spacer(height = wheelSpacerHeight,
                            diameter = wheelSpacerDiameter,
                            shaftDiameter = wheelShaftDiameter,
                            delta = delta);
                    }
                }

            }
        }
    }
}

module screw_hole_with_groove(height, screwHead)
{
    screw_hole(height = height, 
        diameter = screwHoleDiameter,
        delta = delta);
    
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

// Wheel helping methods: Begin

module dog_left_wheel()
{
    dog_wheel_internal(false);
}

module dog_right_wheel()
{
    dog_wheel_internal(true);
}

module dog_wheel_internal(isRightWheel)
{
    dog_wheel(
                wheelWidth = wheelWidth,
                spacerHeight = wheelInternalSpacerHeight,
                spacerDiameter = wheelInternalSpacerDiameter,
                scaleFactor = scaleFactor,
                shaftDiameter = wheelShaftDiameter,
                delta = delta,
                wheelRealDiameter = wheelRealDiameter,
                showDebugFigures = showDebugFigures,
                tenonOffset = wheelTenonOffset,                
                isRightWheel = isRightWheel);
}

// Wheel helping methods: End


// Medium helping methods: Begin

module dog_medium_medium(rounding, roundingRadius)
{
    dog_medium_part_internal(mediumColor, mediumTotalWidth - 2 * mediumSideWidth, rounding, roundingRadius);
}

module dog_medium_side(rounding, roundingRadius)
{
    dog_medium_part_internal(mediumSideColor, mediumSideWidth, rounding, roundingRadius);
}

module dog_medium_part_internal(color, width, rounding, roundingRadius)
{
    color(color, 1.0)
    dog_medium(
                mediumWidth = width,
                expectedLength = expectedLength,
                sideRealLength = sideRealLength,
                scaleFactor = scaleFactor,
                hasRounding = isRoundingOn(rounding, roundingRadius),
                roundingRadius = roundingRadius,
                wheelPlaceDiameter = wheelPlaceDiameter,
                sideMountingHoleCoords = GetSideMountingHoleCoords(rounding, roundingRadius),
                wheelCoords = wheelCoords,
                delta = delta,
                screwHoleDiameter = screwHoleDiameter);
}

// Medium helping methods: End