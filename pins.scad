pin_f_width = 2.54;
pin_f_thickness = 0.8;
pin_header_depth = 11.9;


pin_m_width = 0.7;
pin_m_length = 11.3;
pin_m_inset = (pin_f_width - pin_m_width) / 2;
pin_m_insulation_inset = 3.2;


module m_pin(pin_length=pin_m_length, insulation_inset=pin_m_insulation_inset) {
    cube([pin_f_width, pin_f_width, pin_f_width]);
    translate([pin_m_inset, pin_m_inset, -insulation_inset])
    cube([pin_m_width, pin_m_width, pin_length]);
}

module m_pins(pins, pin_length=pin_m_length, insulation_inset=pin_m_insulation_inset) {
    for (i = [0: pin_f_width: pin_f_width * (pins - 1)]) {
	translate([i, 0, 0])m_pin(pin_length, insulation_inset);
    }
}

module pin_header(pins) {
    for (i = [0: pin_f_width: pin_f_width * (pins - 1)]) {
	translate([i, 0, 0])cube([pin_f_width, pin_f_width, pin_header_depth]);
    }
}


//m_pins(5);
//pin_header(4);
