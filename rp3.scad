include <pins.scad>;
include <usb.scad>;
include <rj45.scad>;
include <hdmi.scad>;
include <microusb.scad>;
include <box.scad>;

$fn = 100;

board_width = 85.1;
board_depth = 56.25;
board_height = 1.3;

board_hole_diameter = 2.75;
board_hole_offset = 3.5;
board_hole_end_offset = 58 + board_hole_offset;

ethernet_y_offset = 10.25 - (rj45_f_width / 2);

usb_port_y_offsets = [29, 47];

port_overhang = 2;
port_z_offset = 0.55;

audio_port_base_width = 7;
audio_port_length = 12;
audio_port_diameter = 6.5;
audio_port_overhang = 2.5;
audio_port_x_offset = 53.5 - (audio_port_base_width / 2);

hdmi_x_offset = 31.75 - (hdmi_f_upper_width / 2);
hdmi_z_offset = 0.6;
hdmi_overhang = 1.5;

microusb_x_offset = 10.25 - (microusb_f_width / 2);
microusb_overhang = 1.5;

microsd_width = 12;
microsd_depth = 15;
microsd_height = 1.5;
microsd_y_offset = 22;
microsd_x_offset = 2.5;

board_bottom_clearance = microsd_height;

module audio_port() {
    translate([0, audio_port_length, 0])
    rotate([90, 0, 0]) {
        translate([audio_port_base_width / 2, audio_port_base_width / 2, audio_port_length])
	cylinder(d=audio_port_diameter, h=audio_port_overhang);
        cube([audio_port_base_width, audio_port_base_width, audio_port_length]);
    }
}

module microsd_port() {
    cube([microsd_depth, microsd_width, microsd_height]);
}

module rp3_board() {
    translate([0, 0, board_bottom_clearance])
    cube([board_width, board_depth, board_height]);
}

module rp3_pegs(taper=false) {
    for (x = [board_hole_offset, board_hole_end_offset]) {
	for (y = [board_hole_offset, board_depth-board_hole_offset]) {
	    translate([x, y, 0])
	    if (taper) {
		cylinder(d1=board_hole_diameter * 1.125, d2=board_hole_diameter * .875, h=board_height+board_bottom_clearance);
	    } else {
		cylinder(d=board_hole_diameter, h=board_height+board_bottom_clearance);
	    }
	}
    }
}


module rp3(insert=false) {
    difference() {
	rp3_board();
	rp3_pegs();
    }
    translate([0, 0, board_height + board_bottom_clearance]) {
        translate([board_width + port_overhang, ethernet_y_offset, port_z_offset])
	rotate([0, 0, 90])
        rj45_port(insert);

	for (y = usb_port_y_offsets) {
	    translate([board_width + port_overhang, y - usb_port_width / 2, port_z_offset])
            rotate([0, 0, 90])
        	usb_port(insert);
	}
	translate([audio_port_x_offset, 0, 0])
	audio_port();

	translate([hdmi_x_offset, -hdmi_overhang, hdmi_z_offset])
	hdmi_port(insert);

	translate([microusb_x_offset, -microusb_overhang, 0]) 
	microusb_female(insert);

	translate([-microsd_x_offset, microsd_y_offset, -microsd_height - board_height])
	microsd_port();

	pin_header_x_offset = board_hole_diameter + board_hole_offset + 1;
	translate([pin_header_x_offset, board_depth - pin_f_width - 1, 0])
	pin_header(20, 1);
    }
}

module magnets(width, length, height, thickness) {
    translate([-thickness + magnet_diameter / 2, -thickness + magnet_diameter / 2, -thickness]) {
	for (x = [magnet_diameter, width / 3, width * 2 / 3,  width - magnet_diameter]) {
	    for (y = [magnet_diameter, length - magnet_diameter]) {
		translate([x, y, 0])
		cylinder(d=magnet_diameter, h=thickness * 2 / 3);
	    }
	}
    }
}

hat_overhang = 4.25;
magnet_diameter = 6.1;

thickness = 1.75;
box_width = board_width + microsd_x_offset + port_overhang;
box_depth = board_depth + thickness + microusb_overhang + hat_overhang;
box_height = board_height + board_bottom_clearance + usb_port_height + port_z_offset + thickness * 2;


hat_pin_header_x_offset = board_hole_offset + board_hole_diameter + get_pin_header_width(20, 1);
hat_pin_header_y_offset = 27.5;
hat_pin_header_z_offset = board_bottom_clearance + board_height + 10;

module box_cutouts(width, length, height, thickness) {
    translate([thickness + microsd_x_offset, thickness, 0]) {
        rp3(1);
	translate([hat_pin_header_x_offset, hat_pin_header_y_offset, hat_pin_header_z_offset]) rotate([0, 0, 90]) pin_header(7, 1);
    }
    magnets(width, length, height, thickness);
}

module box_extras(width, length, height, thickness) {
    translate([microsd_x_offset, 0, 0])
    difference() {
        rp3_pegs(1);
	translate([0, 0, board_bottom_clearance])
	cube([width, length / 2, board_height]);
    }
}


box(box_width, box_depth, box_height, thickness, lid=1);

//translate([thickness + microsd_x_offset, thickness, 0]) {
//    rp3(0);
//    translate([hat_pin_header_x_offset, hat_pin_header_y_offset, hat_pin_header_z_offset]) rotate([0, 0, 90]) pin_header(7, 1);
//}


