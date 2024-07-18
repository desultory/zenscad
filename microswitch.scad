microswitch_diameter = 4.95;
microswitch_depth = 8.4;
microswitch_width = 5.5;
microswitch_height = microswitch_depth; //coincidence?
microswitch_base_height = 7.1;
microswitch_pin_height = 4.75;
microswitch_nut_width = 7.15;
microswitch_nut_od = (microswitch_nut_width / 2) / cos(60);
microswitch_nut_height = 1.75;


module microswitch() {
    microswitch_y_inset = (microswitch_depth - microswitch_diameter) / 2;
    microswitch_x_inset = (microswitch_width - microswitch_diameter) / 2;
    translate([microswitch_diameter / 2 + microswitch_x_inset,
               microswitch_y_inset + microswitch_diameter / 2,
               microswitch_base_height + microswitch_pin_height])
    cylinder(h = microswitch_height, d = microswitch_diameter, $fn = 100);
    translate([0, 0, microswitch_pin_height])
    cube([microswitch_width, microswitch_depth, microswitch_base_height]);
    pin_x_inset = microswitch_width / 4;
    translate([pin_x_inset, 0, 0])
    cube([microswitch_width / 2, microswitch_depth, microswitch_pin_height]);
}

//microswitch();
