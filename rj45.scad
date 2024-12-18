rj45_f_width = 16;
rj45_f_height = 13.5;
rj45_f_depth = 21.7;

rj45_m_width = 12;
rj45_m_height = 10.75;
rj45_m_depth = 22;;

module rj45_port(insert=false) {
    cube([rj45_f_width, rj45_f_depth, rj45_f_height]);
    if (insert) {
	translate([(rj45_f_width - rj45_m_width) / 2,
	           -2, 0])
	rj45_cable();
    }
}

module rj45_cable() {
    cube([rj45_m_width, rj45_m_depth, rj45_m_height]);
}
