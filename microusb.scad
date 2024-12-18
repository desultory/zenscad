microusb_depth = 6;
microusb_f_width = 8.1;
microusb_f_upper_height = 1.33;
microusb_f_lower_width = 5.5;
microusb_f_height = 3.15;

microusb_insert_length = 2.25;
microusb_m_width = 7;
microusb_m_upper_height = 1.25;
microusb_m_lower_width = 5;
microusb_m_height = 2.25;

microusb_m_x_inset = (microusb_f_width - microusb_m_width) / 2;
microusb_m_y_inset = microusb_depth - microusb_insert_length;
microusb_m_z_inset = (microusb_f_height - microusb_m_height) / 2;

microusb_board_width = 14.65;
microusb_board_height = 1.65;
microusb_board_depth = 15.4;
microusb_board_inset = 1;

board_hole_width = 3.25;
board_hole_y = 7.75 + board_hole_width / 2;
board_hole_x = 0.9 + board_hole_width / 2;
board_hole_x2 = microusb_board_width - board_hole_width / 2 - 1.5;

module microusb_female(insert=false) {
    hull() {
        translate([(microusb_f_width - microusb_f_lower_width) / 2, 0, 0])
        cube([microusb_f_lower_width, microusb_depth, 0.01]);
        translate([0, 0, microusb_f_height - microusb_f_upper_height])
        cube([microusb_f_width, microusb_depth, microusb_f_upper_height]);
    }
    if (insert) {
	translate([0, -(microusb_depth), (microusb_f_height - microusb_m_height) / 4])
	microusb_male(true);
    }
}

module microusb_male(inset=false) {
    x_offset = inset ? microusb_m_x_inset : 0;
    hull() {
        translate([(microusb_m_width - microusb_m_lower_width) / 2  + x_offset, microusb_m_y_inset, microusb_m_z_inset])
        cube([microusb_m_lower_width, microusb_depth, 0.001]);
        translate([x_offset, microusb_m_y_inset, microusb_m_height - microusb_m_upper_height + microusb_m_z_inset])
        cube([microusb_m_width, microusb_depth, microusb_m_upper_height]); 
    }
}

module microusb_board(cutout=false) {
    difference() {
        cube([microusb_board_width, microusb_board_depth, microusb_board_height]);
	microusb_board_pegs();
    }
    translate([(microusb_board_width - microusb_f_width) / 2, -microusb_board_inset, microusb_board_height])
    microusb_female(cutout);
    if (cutout) {
	translate([(microusb_board_width - microusb_f_width) / 2,
		   -microusb_board_inset + microusb_board_inset / 2,
		   microusb_board_height + microusb_f_height])
	cube([microusb_f_width, microusb_depth, microusb_board_height]);
	translate([0, 0, microusb_board_height])
	cube([microusb_board_width, microusb_board_depth, microusb_board_height]);
    }
}

module microusb_board_pegs() {
    translate([board_hole_x, board_hole_y, 0])
    cylinder(h=microusb_board_height + 1, r=board_hole_width/2, $fn=100);
    translate([board_hole_x2, board_hole_y, 0])
    cylinder(h=microusb_board_height + 1, r=board_hole_width/2, $fn=100);
}


//microusb_board(0);
//microusb_board_pegs();

//microusb_male();
