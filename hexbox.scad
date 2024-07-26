include <hex.scad>;

radius = 3;
margin = 0.5;


box_width =  57;
box_depth = 16;
box_height = 20;


hexface(radius=radius, margin=margin, x=box_width, y=box_depth);

y = get_hex_y(radius, margin, box_depth);
z = get_hex_y(radius, margin, box_height);


translate([0, margin, 0]) rotate([90, 0, 0]) hexface(radius=radius, margin=margin, x=box_width, y=box_height);
translate([0, y, 0]) rotate([90, 0, 0]) hexface(radius=radius, margin=margin, x=box_width, y=box_height);

rotate([90, 0, 90]) translate([0, 0, 0]) hexface(radius=radius, margin=margin, x=box_depth, y=box_height);


