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
    clutchHeight,
    isRightWheel = false
    )
{
    translate([0, 0, wheelWidth * 0.5]) 
    {
        difference()
        {
            dog_wheel_spacer(height = spacerHeight + wheelWidth * 0.5,
                            diameter = spacerDiameter,
                            shaftDiameter = shaftDiameter,
                            delta = delta
                            );
            rotate([0, 0, 45 * 0.5])
                translate([spacerDiameter * 0.5, 0, (wheelWidth - clutchHeight + delta) * 0.5 + spacerHeight ])
                    cube([spacerDiameter, spacerDiameter, clutchHeight + delta], center=true);
        }
        difference()
        {
            mirror( isRightWheel ? [1, 0, 0] : [0, 0, 1]) 
                scale([scaleFactor, scaleFactor, 1]) 
                    translate([0.6, -1.1, 0])// centering
                        linear_extrude(height = wheelWidth, convexity=20, center = true) 
                            import(file = "dog_4_scad_wheel.svg", center=true, $fn=360);

            cylinder(h = wheelWidth + delta, d = shaftDiameter, center = true, $fn = 360);        
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