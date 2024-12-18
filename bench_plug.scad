bench_plug_hole_diameter = 19;
bench_plug_hole_depth = 30;
bench_plug_wall_thickness = 3;
bench_plug_top_thickness = 5;


module bench_plug(plug_depth=bench_plug_hole_depth / 2, plug_diameter=bench_plug_hole_diameter,
		  wall_thickness=bench_plug_wall_thickness, top_thickness=bench_plug_top_thickness,
		  plug_pad=0.3, inner_diameter=0, outer_diameter=0,
                  slivers=9, sliver_distance=0, sliver_scale_x=0.3, sliver_scale_y=0.5, sliver_skew_x=5.5, sliver_skew_y=0) {
    d = plug_diameter + plug_pad;
    plug_scale = d /plug_diameter;
    inner_diameter = inner_diameter ? inner_diameter : d / 2;
    outer_diameter = outer_diameter ? outer_dimater : d + wall_thickness * 2;
    sliver_distance = sliver_distance ? sliver_distance : inner_diameter;
    linear_extrude(plug_depth, scale=plug_scale)
    difference(){
        circle(d=d);
        circle(d=inner_diameter);
        // Slivers (polygons)
        plug_slivers(d, slivers, sliver_distance, sliver_scale_x, sliver_scale_y, sliver_skew_x, sliver_skew_y);
    }
    bench_plug_top(outer_diameter, plug_depth, top_thickness);
    translate([0, 0, plug_depth + wall_thickness * 2]) bench_plug_attachments();
}

module bench_plug_top(outer_diameter, plug_depth, top_thickness) {
    translate([0, 0, plug_depth])
    linear_extrude(top_thickness)
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
