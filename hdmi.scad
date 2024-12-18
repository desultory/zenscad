hdmi_f_upper_width = 15.15;
hdmi_f_lower_width = 10.75;
hdmi_f_upper_height = 4.3;
hdmi_f_height = 6.05;
hdmi_f_depth = 11.5;

hdmi_m_upper_width = 14.1;
hdmi_m_lower_width = 10;
hdmi_m_upper_height = 3.3;
hdmi_m_height = 4.33;
hdmi_m_depth = 11.5;

module hdmi_port(insert=false) {
    hull() {
        translate([(hdmi_f_upper_width - hdmi_f_lower_width) / 2, 0, 0])
	  cube([hdmi_f_lower_width, hdmi_f_depth, 0.0001]);
        translate([0, 0, hdmi_f_height - hdmi_f_upper_height])
          cube([hdmi_f_upper_width, hdmi_f_depth, hdmi_f_upper_height]);
    }
    if (insert) {
	translate([(hdmi_f_upper_width - hdmi_m_upper_width) / 2,
		    -2, 
 	            (hdmi_f_height - hdmi_m_height) / 2])
	hdmi_male();
    }
}

module hdmi_male() {
    hull() {
	translate([(hdmi_m_upper_width - hdmi_m_lower_width) / 2, 0, 0])
	  cube([hdmi_m_lower_width, hdmi_m_depth, 0.0001]);
	translate([0, 0, hdmi_m_height - hdmi_m_upper_height])
	  cube([hdmi_m_upper_width, hdmi_m_depth, hdmi_m_upper_height]);
    }
}


