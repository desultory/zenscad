include <usbc.scad>

rpzero_board_width = 18;
rpzero_board_height = 2.1;
rpzero_board_depth = 24.3;
rpzero_board_zplus = 2.55;

rpzero_usb_c_y_offset = 0.45;
rpzero_usb_c_x_offset = (rpzero_board_width - usb_c_f_width) / 2;


module rpzero_board() {
    cube([rpzero_board_width, rpzero_board_depth, rpzero_board_height]);
}

module rpzero_top_clearance() {
    translate([0, 0, rpzero_board_height])
    cube([rpzero_board_width, rpzero_board_depth, rpzero_board_zplus]);
    translate([rpzero_usb_c_x_offset, -rpzero_usb_c_y_offset, rpzero_board_height])
    cube([usb_c_f_width, usb_c_f_depth, rpzero_board_zplus + usb_c_f_height]);
}


module rpzero(clearance=false) {
    rpzero_board();
    translate([rpzero_usb_c_x_offset, -rpzero_usb_c_y_offset, rpzero_board_height])
		usb_c_f(clearance);
    if (clearance) {
	rpzero_top_clearance();
    }
}

//rpzero(true);
