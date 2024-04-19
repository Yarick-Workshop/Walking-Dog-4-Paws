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