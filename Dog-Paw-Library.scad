module dog_wheel_spacer(height, diameter, shaftDiameter, delta)
{
    if (height != 0)
    {
        difference()
        {
            cylinder(h=height, d = diameter, $fn=360);
            translate([0,0, -delta * 0.5])
                cylinder(h=height + delta, d=shaftDiameter, $fn=360);
        }
    }
}

module dog_wheel(
    wheelWidth,
    spacerHeight,
    spacerDiameter,
    scaleFactor,
    shaftDiameter,
    delta,
    wheelRealDiameter,
    showDebugFigures,
    tenonOffset,
    isRightWheel,
    internalSpacerHeight
    )
{
    cubeSideWidth = sqrt( spacerDiameter * spacerDiameter / 2 );
    
    translate([0, 0, wheelWidth * 0.5]) 
    {
        if (isRightWheel)
        {
            dog_wheel_spacer(height = spacerHeight + wheelWidth * 0.5,
                            diameter = spacerDiameter,
                            shaftDiameter = shaftDiameter,
                            delta = delta
                            );            
            
            rotate([0, 0, 45 * 0.5])
                translate([0, 0, wheelWidth  + spacerHeight - delta])
                difference()
                {
                    cube([cubeSideWidth,
                          cubeSideWidth,
                          wheelWidth + delta],
                          center=true);
                    cylinder(h= wheelWidth + 2 * delta,
                             d = shaftDiameter,
                             center = true,
                             $fn=360);
                }
            
        }
        difference()
        {
            mirror( isRightWheel ? [1, 0, 0] : [0, 0, 1]) 
                scale([scaleFactor, scaleFactor, 1]) 
                    translate([0.6, -1.1, 0])// centering
                        linear_extrude(height = wheelWidth, convexity=20, center = true) 
                            import(file = "dog_4_scad_wheel.svg", center=true, $fn=360);

            cylinder(h = wheelWidth + delta, d = shaftDiameter, center = true, $fn = 360);
            
            if (!isRightWheel)
            {
                rotate([0, 0, 45 * 0.5])
                    cube([cubeSideWidth + 2 * tenonOffset, 
                        cubeSideWidth + 2 * tenonOffset,
                        wheelWidth + delta],
                        center = true);
            }
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