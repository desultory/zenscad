microusb_depth = 6;
microusb_f_width = 8;
microusb_f_upper_height = 1.25;
microusb_f_lower_width = 5.5;
microusb_f_height = 3;

microusb_insert_length = 2.25;
microusb_m_width = 7;
microusb_m_upper_height = 1.25;
microusb_m_lower_width = 5;
microusb_m_height = 2.25;

microusb_m_x_inset = (microusb_f_width - microusb_m_width) / 2;
microusb_m_y_inset = microusb_depth - microusb_insert_length;
microusb_m_z_inset = (microusb_f_height - microusb_m_height) / 2;

module microusb_female() {
    hull() {
        translate([(microusb_f_width - microusb_f_lower_width) / 2, 0, 0])
        cube([microusb_f_lower_width, microusb_depth, 0.01]);
        translate([0, 0, microusb_f_height - microusb_f_upper_height])
        cube([microusb_f_width, microusb_depth, microusb_f_upper_height]);
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

//microusb_male();