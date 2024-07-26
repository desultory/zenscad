$fn = 100;

lid_rail_thickness = 1.75;


module stripe(width, length, gap, thickness, angle=45) {
    neg = angle < 0 ? 1 : 0;
    a = abs(angle) % 360;
    dir = angle > 180 ? 0 : -1;
    w = width * 2 + gap;
    x_offset = angle > 180 ? w / -2 : 0;
    l = length / cos(a) + gap;
    for (x = [0: gap * 2: w]) {
        y_thick_offset = sin(a) * gap * dir;
        translate([x_offset + x / cos(a), y_thick_offset, 0])
        rotate([0, 0, a])
        hull() {
            cube([gap, l, 0.0001]);
            translate([(gap / 2) - (gap / 8), 0, thickness - 0.0001])
            cube([gap / 4, l, 0.0001]);
        }
    }
}


module box_base(width, length, height, thickness, texture_bottom) {
    translate([width / 2 + thickness, length / 2 + thickness, -thickness])
    difference() {
        linear_extrude(height + thickness) offset(thickness) square([width, length], center=true);
        translate([0, 0, thickness]) linear_extrude(height) square([width, length], center=true);
        

        if (texture_bottom) {
            translate([-width / 2, -length / 2, 0]) stripe(width, length + thickness * 2, thickness, thickness / 2);
            translate([-width / 2, -length / 2, 0]) stripe(width, length + thickness * 2, thickness, thickness / 2, angle=315);
        }
    }
    if (texture_bottom) {
       translate([width / 2 + thickness, length / 2 + thickness, -thickness])
       difference() {
            linear_extrude(thickness) offset(thickness) square([width, length], center=true);
            linear_extrude(thickness) square([width, length], center=true);
       }
   }
}

module box(width, length, height, thickness=1.75, texture_bottom=false, lid=false, lid_rail_thickness=lid_rail_thickness, lid_removal_cutout=true) {
    difference() {
        box_base(width, length, height, thickness, texture_bottom);
        box_cutouts(width, length, height, thickness);
	if (lid_removal_cutout) {
	    lid_removal_cutout(width, length, height, thickness);
	}
    }

    translate([thickness, thickness, 0]) box_extras(width, length, height, thickness);
    if (lid) {
        translate([width + thickness * 4, 0, -thickness])
        lid(width, length, height, thickness, texture_bottom, lid_rail_thickness);
    }
}

module lid_removal_cutout(width, length, height, thickness, cutout_size=10) {
    for (x = [0, width + thickness]) {
	translate([x, (length + thickness * 2 - cutout_size) / 2, height - thickness])
	cube([thickness + 0.1, cutout_size, thickness]); // not sure why it needs padding...
    }
}

module box_cutouts(width, length, height, thickness) {}
module box_extras(width, length, height, thickness) {}

module lid_base(width, length, height, thickness, texture_bottom) {
    difference() {
        hull () {
            translate([thickness, thickness])
            cube([width, length, 0.01]);
            translate([thickness, thickness, thickness - 0.01])
            linear_extrude(0.01) offset(thickness) square([width, length]);
        }
        if (texture_bottom) {
            stripe(width, length + thickness * 2, thickness, thickness / 2);
            stripe(width, length + thickness * 2, thickness, thickness / 2, angle=315);
        }
    }
    translate([thickness, thickness, 0]) lid_rails(width, length, height, thickness, lid_rail_thickness);
    translate([thickness, thickness, thickness]) lid_extras(width, length, height, thickness);
}

module lid(width, length, height, thickness=2, texture_bottom=false, lid_rail_thickness=0) {
    difference() {
        lid_base(width, length, height, thickness, texture_bottom);
        lid_cutouts(width, length, height, thickness);
	translate([width + thickness * 2, 0, height]) rotate([0, 180, 0])
	box_cutouts(width, length, height, thickness);
    }
}

module lid_cutouts(width, length, height, thickness) {}
module lid_extras(width, length, height, thickness) {}

module lid_rails(width, length, height, thickness, lid_rail_thickness=1.75, y_size=0, z_size=0, inset=0.05) {
    z_size = z_size ? z_size : height / 3;
    for (x_offset = [-inset, width - lid_rail_thickness+ inset]) {
        translate([x_offset, 0, 0])
        cube([lid_rail_thickness, length, z_size + thickness]);
    }
    for (y_offset = [-inset, length - lid_rail_thickness + inset]) {
        translate([0, y_offset, 0])
        cube([width, lid_rail_thickness, z_size + thickness]);
    }
}

module lid_pegs(width, length, height, thickness, x_size=1.75, y_size=2.5, z_size=0, inset=0.15) {
    z_size = z_size ? z_size : height / 3;
    for (x_offset = [-inset, width - x_size + inset]) {
        for (y_offset = [0, length / 2 - thickness, length - y_size]) {
            translate([x_offset, y_offset, 0])
            cube([x_size, y_size, z_size]);
        }
    }
}


//box(20, 20, 5, lid=true, texture_bottom=true);
