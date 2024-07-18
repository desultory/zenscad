module bench_plug(plug_depth=15, plug_ideal=19, plug_pad=0.3, inner_diameter=0, outer_diameter=0, wall_thickness=3,
                  slivers=9, sliver_distance=0, sliver_scale_x=0.3, sliver_scale_y=0.5, sliver_skew_x=5.5, sliver_skew_y=0) {
    plug_diameter = plug_ideal + plug_pad;
    plug_scale = plug_diameter / plug_ideal;
    inner_diameter = inner_diameter ? inner_diameter : plug_diameter / 2;
    outer_diameter = outer_diameter ? outer_dimater : plug_diameter + wall_thickness * 2;
    sliver_distance = sliver_distance ? sliver_distance : inner_diameter;
    linear_extrude(plug_depth, scale=plug_scale)
    difference(){
        circle(d=plug_diameter);
        circle(d=inner_diameter);
        // Slivers (polygons)
        plug_slivers(plug_diameter, slivers, sliver_distance, sliver_scale_x, sliver_scale_y, sliver_skew_x, sliver_skew_y);
    }
    bench_plug_top(outer_diameter, plug_depth, wall_thickness);
    translate([0, 0, plug_depth + wall_thickness * 2]) bench_plug_attachments();
}

module bench_plug_top(outer_diameter, plug_depth, wall_thickness) {
    translate([0, 0, plug_depth])
    linear_extrude(wall_thickness * 2)
    circle(d = outer_diameter);
}

module bench_plug_attachments();


module plug_slivers(plug_diameter, slivers, sliver_distance, sliver_scale_x, sliver_scale_y, sliver_skew_x, sliver_skew_y) {
    for (i = [0 : slivers]) {
        rotate([0, 0, i * 360 / slivers]) 
        translate([plug_diameter / 3, 0, -6])
        polygon(points=[[sliver_skew_x, sliver_skew_y],
                        [sliver_distance * sliver_scale_x, sliver_distance * sliver_scale_y],
                        [-sliver_distance * sliver_scale_x, sliver_distance * sliver_scale_y]]);
    }
}