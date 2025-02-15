include <hex.scad>;

module hexbox(radius=3, margin=1, box_width, box_depth, box_height, thickness=1) {
    y = get_hex_y(radius, margin, box_depth, thickness);
    z = get_hex_y(radius, margin, box_height, thickness);
    x = get_hex_x(radius, margin, box_width, thickness);
    echo("x_count = ", get_x_count(radius, margin, box_width));
    echo("y_count = ", get_y_count(radius, margin, box_depth));
    echo("x_step = ", get_x_step(radius, margin));
    echo("tile_width = ", get_tile_width(radius, margin));
    echo("tile_height = ", get_tile_height(radius, margin));
    echo("hex_height = ", get_hex_height(radius));
    echo("x = ", x);
    echo("y = ", y);

    // Bottom
    translate([0, 0, -.25])
    hexface(radius=radius, margin=margin, x=box_width, y=box_depth, thickness=thickness);

    // front/back
    translate([0, thickness, 0]) rotate([90, 0, 0]) hexface(radius=radius, margin=margin, x=box_width, y=box_height, thickness=thickness);
    translate([0, y, 0]) rotate([90, 0, 0]) hexface(radius=radius, margin=margin, x=box_width, y=box_height, thickness=thickness);

    // sides
    rotate([90, 0, 90]) translate([0, 0, 0]) cube([y, z, thickness]);
    rotate([90, 0, 90]) translate([0, 0, x - thickness]) cube([y, z, thickness]);

    // top ring
    for (z_ring_offset = [0, z - radius]) {
        translate([0, 0, z_ring_offset]) {
	    difference() {
	        cube([x, y, radius]);
		translate([thickness, thickness, 0]) cube([x - 2 * thickness, y - 2 * thickness, radius]);
	    }
	}
    }
}

