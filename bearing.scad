bearing_outer_diameter = 22;
bearing_inner_diameter = 8;
bearing_depth = 7;


module bearing() {
    linear_extrude(bearing_depth)
    difference() {
        circle(d=bearing_outer_diameter, $fn=100);
        circle(d=bearing_inner_diameter, $fn=100);
    }
}