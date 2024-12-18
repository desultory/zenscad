usb_depth = 14.5;
usb_insert_length = 11.5;
usb_m_width = 12.3;
usb_m_height = 4.6;

usb_port_width = 15.25;
usb_port_depth = 17.25;
usb_port_height = 16;

module usb_port(insert=false) {
    cube([usb_port_width, usb_port_depth, usb_port_height]);
    if (insert) {
	translate([(usb_port_width - usb_m_width) / 2, -2, 0]) {
	    for (z = [1.25, usb_port_height - 1.1 - usb_m_height]) {
		translate([0, 0, z]) usb_male();
	    }
	}
    }
}

module usb_male() {
    cube([usb_m_width, usb_depth, usb_m_height]);
}

//usb_male();
