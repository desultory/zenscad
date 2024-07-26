include <pins.scad>

ws485_board_depth = 41.85;
ws485_board_width = 16.9;
ws485_board_height = 1.62;
ws485_board_neg_height = 1.4;

ws485_jack_width = 12.25;
ws485_jack_height = 14.75;
ws485_jack_depth = 13.25;
ws485_jack_peg_inset = 5;

ws485_jack_offset_x = (ws485_board_width - ws485_jack_width) / 2;
ws485_jack_offset_y = ws485_board_depth - ws485_jack_depth;

ws485_screw_term_depth = 10.25;
ws485_screw_term_width = 7.75;
ws485_screw_term_height = 10.25;
ws485_screw_term_insert_height = 4.5;
ws485_screw_term_top_width = 6;
ws485_screw_term_inset = 2;

ws485_pin_x = (ws485_board_width - 5 * pin_f_width) / 2;
ws485_pin_length = 10.5;
ws485_pin_insulation_inset = 1;

ws485_pin_inset = ws485_pin_insulation_inset + pin_f_width;
ws485_pin_overhang = ws485_pin_length - ws485_pin_inset;

module ws485_board() {
    cube([ws485_board_width, ws485_board_depth, ws485_board_height]);
}

module ws485_bottom_clearance() {
    translate([0, 0, -ws485_board_neg_height])
    cube([ws485_board_width, ws485_board_depth - ws485_jack_peg_inset, ws485_board_neg_height]);
}

module ws485_jack() {
	cube([ws485_jack_width, ws485_jack_depth, ws485_jack_height]);
}

module ws485_screwterm(cutout=false) {
    x_offset = cutout ? -10 : 0;
    x_inc = cutout ? 10 : 0;
    z_inc = cutout ? 10 : 0;
    seventh = ws485_screw_term_depth / 7;
    cube([ws485_screw_term_width, ws485_screw_term_depth, ws485_screw_term_height]);
    if (cutout) {
	translate([x_offset, seventh, ws485_board_height])
	cube([ws485_screw_term_width + x_inc, seventh * 2, ws485_screw_term_insert_height]);
	translate([x_offset, seventh * 4, ws485_board_height])
	cube([ws485_screw_term_width + x_inc, seventh * 2, ws485_screw_term_insert_height]);
	cube([ws485_screw_term_top_width, ws485_screw_term_depth, ws485_screw_term_height + z_inc]);
    }
}

module ws485(clearance=false) {
    ws485_board();
    translate([ws485_jack_offset_x, ws485_jack_offset_y, ws485_board_height]) ws485_jack();

    translate([ws485_screw_term_inset, ws485_board_depth - ws485_jack_depth - ws485_screw_term_depth, 0])
    ws485_screwterm(clearance);

    translate([ws485_pin_x, pin_f_width, ws485_board_height])
    rotate([90, 0 ,0])
    m_pins(5, pin_length=ws485_pin_length, insulation_inset=ws485_pin_insulation_inset);
    if (clearance) {
	ws485_bottom_clearance();
    }
}

//ws485();


