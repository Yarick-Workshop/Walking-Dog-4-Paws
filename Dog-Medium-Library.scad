use <Dog-Utils.scad>

module dog_medium(
    mediumWidth,
    expectedLength,
    sideRealLength,
    scaleFactor,
    hasRounding,
    roundingRadius,
    wheelPlaceDiameter,
    sideMountingHoleCoords,
    wheelCoords,
    delta,
    screwHoleDiameter)
{
    difference()
    {
        dog_medium_internal(mediumWidth = mediumWidth,
            expectedLength = expectedLength,
            sideRealLength = sideRealLength,
            scaleFactor = scaleFactor,
            hasRounding = hasRounding,
            roundingRadius = roundingRadius);
        union()
        {
            for(coord = sideMountingHoleCoords)
            {
                translate([coord[0], coord[1], 0])
                    screw_hole(height = mediumWidth, diameter = screwHoleDiameter, delta = delta);
            }
            for (wheelCoord = wheelCoords)
            {
                translate([wheelCoord[0], wheelCoord[1], 0])
                        cylinder(h = mediumWidth + delta, d = wheelPlaceDiameter, center=true, $fn = 360);
            }
        }
    }
}

module dog_medium_internal(mediumWidth,
    expectedLength,
    sideRealLength,
    scaleFactor,
    hasRounding,
    roundingRadius)
{
    if (hasRounding)
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