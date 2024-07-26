usb_depth = 14.5;
usb_insert_length = 11.5;
usb_m_width = 12;
usb_m_height = 4.5;

module microusb_female() {
    hull() {
        translate([(microusb_f_width - microusb_f_lower_width) / 2, 0, 0])
        cube([microusb_f_lower_width, microusb_depth, 0.01]);
        translate([0, 0, microusb_f_height - microusb_f_upper_height])
        cube([microusb_f_width, microusb_depth, microusb_f_upper_height]);
    }
}

module usb_male() {
    cube([usb_m_width, usb_depth, usb_m_height]);
}

//usb_male();
