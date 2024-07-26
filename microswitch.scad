microswitch_diameter = 4.95;
microswitch_depth = 8.4;
microswitch_width = 5.5;
microswitch_height = microswitch_depth; //coincidence?
microswitch_base_height = 7.1;
microswitch_pin_height = 4.75;
microswitch_nut_width = 7.15;
microswitch_nut_od = (microswitch_nut_width / 2) / cos(60);
microswitch_nut_height = 1.75;

miniswitch_diameter = 5.8;
miniswitch_height = 9;
miniswitch_depth = 13.15;
miniswitch_width = 8.1;
miniswitch_base_height = 9.75;
miniswitch_pin_height = 5;
miniswitch_nut_width = 8.3;
miniswitch_nut_od = (miniswitch_nut_width / 2) / cos(60);
miniswitch_nut_height = 2;


module switch(height, diameter, width, depth, base_height, pin_height) {
    y_inset = (depth - diameter) / 2;
    x_inset = (width - diameter) / 2;
    translate([diameter / 2 + x_inset,
               y_inset + diameter / 2,
               base_height + pin_height])
    cylinder(h = height, d = diameter, $fn = 100);
    translate([0, 0, pin_height])
    cube([width, depth, base_height]);
    pin_x_inset = width / 4;
    translate([pin_x_inset, 0, 0])
    cube([width / 2, depth, pin_height]);
}

module microswitch() {
    switch(microswitch_height, microswitch_diameter, microswitch_width, microswitch_depth, microswitch_base_height, microswitch_pin_height);
}

module miniswitch() {
	switch(miniswitch_height, miniswitch_diameter, miniswitch_width, miniswitch_depth, miniswitch_base_height, miniswitch_pin_height);
}

//miniswitch();
