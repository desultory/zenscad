include <pins.scad>


ssd1306_board_width = 25.4;
ssd1306_board_depth = 26.4;
ssd1306_board_height = 1.6;

ssd1306_display_height = 16.75;
ssd1306_display_thickness = 1.6;
ssd1306_display_y_offset = 4.8;

ssd1306_hole_diameter = 2;
ssd1306_hole_inset_x_a = 1.3;
ssd1306_hole_inset_x_b = 1;
ssd1306_hole_inset_y = 1.2;

ssd1306_pin_width = pin_f_width * 4;
ssd1306_pin_x = (ssd1306_board_width - ssd1306_pin_width) / 2;

ssd1306_component_height = 1.25;
ssd1306_component_y_offset = ssd1306_hole_inset_y + ssd1306_hole_diameter;
ssd1306_component_depth = 13;


module ssd1603_board() {
    difference() {
        cube([ssd1306_board_width, ssd1306_board_depth, ssd1306_board_height]);
	ssd1306_holes();
    }
}

module ssd1306_display() {
    cube([ssd1306_board_width, ssd1306_display_height, ssd1306_display_thickness]);
}

module ssd1306_hole() {
    cylinder(d=ssd1306_hole_diameter, h=ssd1306_board_height, $fn=100);
}

module ssd1306_components() {
    cube([ssd1306_board_width, ssd1306_component_depth, ssd1306_component_height]);
}

module ssd1306_holes() {
    translate([ssd1306_hole_diameter / 2, ssd1306_hole_diameter / 2, 0]) {
	for (y = [ssd1306_hole_inset_y, ssd1306_board_depth - ssd1306_hole_diameter - ssd1306_hole_inset_y]) {
	    translate([ssd1306_hole_inset_x_a, y, 0])
	    ssd1306_hole();
	    translate([ssd1306_board_width - ssd1306_hole_diameter - ssd1306_hole_inset_x_b, y, 0])
	    ssd1306_hole();
	}
    }
}


module ssd1306() {
    ssd1603_board();
    translate([0, ssd1306_display_y_offset, ssd1306_board_height]) 
    ssd1306_display();

    translate([ssd1306_board_width - ssd1306_pin_x, 0, 0])
    rotate([0, 180, 0])
    m_pins(4);

    translate([0, ssd1306_component_y_offset, -ssd1306_component_height])
    ssd1306_components();
}

ssd1306();
