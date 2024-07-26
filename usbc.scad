
usb_c_thickness = 0.3;
usb_c_f_height = 3.2;
usb_c_f_width = 9;
usb_c_f_depth = 7.35;
usb_c_f_core_width = 7.5;
usb_c_f_core_inset = (usb_c_f_width - usb_c_f_core_width) / 2;
usb_c_f_core_height = usb_c_f_height - usb_c_f_core_inset * 2;

usb_c_m_height = 2.5;
usb_c_m_width = 8.25;
usb_c_m_depth = 6.75;;
usb_c_m_core_width = 6.75;
usb_c_m_core_inset = (usb_c_m_width - usb_c_m_core_width) / 2;
usb_c_m_core_height = usb_c_m_height - usb_c_m_core_inset * 2;

usb_c_m_x_offset = (usb_c_f_width - usb_c_m_width) / 2;
usb_c_m_z_offset = (usb_c_f_height - usb_c_m_height) / 2;
usb_c_insert_depth = 1.5;


module usb_c_f(insert = false) {
    translate([usb_c_f_core_inset, usb_c_f_depth, usb_c_f_core_inset])
    rotate([90, 0, 0])
    linear_extrude(height=usb_c_f_depth)
    offset(r=usb_c_f_core_inset, $fn=100)
    square([usb_c_f_width - usb_c_f_core_inset * 2, usb_c_f_core_height]);
    if (insert) {
	usb_c_m(true);
    }	
}

module usb_c_m(inset=false) {
    x_offset = inset ? usb_c_m_x_offset : 0;
    z_offset = inset ? usb_c_m_z_offset : 0;
    y_offset = inset ? -usb_c_insert_depth: 0;
    translate([usb_c_m_core_inset + x_offset, usb_c_m_depth + y_offset, usb_c_m_core_inset + z_offset])
	rotate([90, 0, 0])
	linear_extrude(height=usb_c_m_depth)
	offset(r=usb_c_m_core_inset, $fn=100)
	square([usb_c_m_width - usb_c_m_core_inset * 2, usb_c_m_core_height]);
}


//usb_c_f(true);

//usb_c();
