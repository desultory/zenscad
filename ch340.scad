include <microusb.scad>;

$fn = 50;
thickness = 1;

ch340_depth = 17;
ch340_width = 15.6;
ch340_board_height = 1.6;
ch340_peg_diameter = 1.75;
ch340_peg_inset = 0.25;
ch340_peg_y = [4.5, 14.5];
ch340_usb_inset = 0.5;

z_offset = 0.25;

module ch340(){
    difference() {
        translate([0, 0, z_offset])
        cube([ch340_width, ch340_depth, ch340_board_height]);
        translate([0, 0, z_offset])
        ch340_pegs();
    }
    translate([(ch340_width - microusb_f_width) / 2, ch340_depth - microusb_depth + ch340_usb_inset, ch340_board_height + z_offset]) microusb_female();
    translate([(ch340_width - microusb_f_width) / 2, ch340_depth - microusb_depth + ch340_usb_inset, ch340_board_height + z_offset]) microusb_male(true);
}

module ch340_pegs() {
    peg_offset = ch340_peg_inset + ch340_peg_diameter / 2;
    for (y = ch340_peg_y) {
        for(x = [peg_offset, ch340_width - peg_offset]) {
            translate([x, y, -ch340_peg_inset])
            cylinder(h = ch340_peg_inset + ch340_board_height, d = ch340_peg_diameter);
        }
    }
}

module ch340_rails() {
    translate([-thickness, 0, 0])
    cube([thickness, ch340_depth, ch340_board_height + z_offset]);
    translate([ch340_width, 0, 0])
    cube([thickness, ch340_depth, ch340_board_height + z_offset]);
}

module ch340_cutout() {
    translate([0, -thickness, 0])
    cube([ch340_width, ch340_depth + thickness, ch340_board_height + z_offset + thickness * 2]);
    translate([(ch340_width - microusb_f_width) / 2, ch340_depth - microusb_depth + thickness / 2 + ch340_usb_inset, ch340_board_height + ch340_peg_inset + ch340_board_height])
    cube([microusb_f_width, microusb_depth - thickness / 2, microusb_f_height]);
}

//ch340();
//ch340_cutout();
