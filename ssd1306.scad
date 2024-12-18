include <pins.scad>

ssd1306_board_width = 28.1;
ssd1306_board_length = 28.1;
ssd1306_board_height = 1.2;

ssd1306_display_height = 19.5;
ssd1306_display_thickness = 2;
ssd1306_display_y_offset = 4;

ssd1306_hole_diameter = 1.95;
ssd1306_hole_inset_x_a = 1.35;
ssd1306_hole_inset_x_b = 1.05;
ssd1306_hole_inset_y = 1.25;

ssd1306_pin_width = pin_f_width * 4;
ssd1306_pin_x = (ssd1306_board_width - ssd1306_pin_width) / 2;

ssd1306_component_height = 1.25;
ssd1306_component_y_offset = ssd1306_hole_inset_y + ssd1306_hole_diameter;
ssd1306_component_length = 13;


module ssd1603_board(no_holes=false) {
    difference() {
        cube([ssd1306_board_width, ssd1306_board_length, ssd1306_board_height]);
	if (!no_holes) {
	   ssd1306_pegs();
	}
    }
}

module ssd1306_display(clearance=false) {
    z_inc = clearance ? 5 : 0;
    cube([ssd1306_board_width, ssd1306_display_height, ssd1306_display_thickness + z_inc]);
}

module ssd1306_peg() {
    cylinder(d=ssd1306_hole_diameter, h=ssd1306_board_height, $fn=100);
}

module ssd1306_components() {
    cube([ssd1306_board_width, ssd1306_component_length, ssd1306_component_height]);
}

module ssd1306_pegs() {
    translate([ssd1306_hole_diameter / 2, ssd1306_hole_diameter / 2, 0]) {
	for (y = [ssd1306_hole_inset_y, ssd1306_board_length - ssd1306_hole_diameter - ssd1306_hole_inset_y]) {
	    translate([ssd1306_hole_inset_x_a, y, 0])
	    ssd1306_peg();
	    translate([ssd1306_board_width - ssd1306_hole_diameter - ssd1306_hole_inset_x_b, y, 0])
	    ssd1306_peg();
	}
    }
}


module ssd1306(clearance=false, no_holes=false) {
    ssd1603_board(no_holes);
    translate([0, ssd1306_display_y_offset, ssd1306_board_height]) 
    ssd1306_display(clearance);

    translate([ssd1306_board_width - ssd1306_pin_x, 0, 0])
    rotate([0, 180, 0])
    if (clearance) {
	pin_header(4, 1, 3);
    } else {
        m_pins(4);
    }

    translate([0, ssd1306_component_y_offset, -ssd1306_component_height])
    ssd1306_components();
}

//ssd1306();
