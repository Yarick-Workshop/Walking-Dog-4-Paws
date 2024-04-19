module screw_hole(height, diameter, delta)
{
    cylinder(h = height + delta, d = diameter, center = true, $fn=360);
}