
// The margin added to the hexagon point (x end)
function get_x_margin(margin) = 2 * margin * cos(30);
// The full width of each "tile", for columns
function get_tile_width(radius, margin) = (2 * radius) + get_x_margin(margin);
// The height of each "tile", for rows
function get_tile_height(radius, margin) = (2 * radius) + margin;
function get_hex_height(radius) = 2 * radius * cos(30);
function get_x_step(radius, margin) = get_tile_width(radius, margin) + (radius * 1 + cos(60));
function get_x_count(radius, margin, x) =
    ceil(x / (radius * 2));
function get_hex_x_offset(radius, margin, x, thickness) = floor(get_x_count(radius, margin, x)) % 2 ? 
    0:
    - (margin - thickness);
function get_hex_x(radius, margin, x, thickness) = get_x_count(radius, margin, x) * get_tile_width(radius, margin);
// Get the number of hexagons which span the y axis
function get_y_count(radius, margin, y) = ceil(y / get_tile_height(radius, margin));
// Get the y size based on a in input, fit to the hexagon grid
function get_hex_y(radius, margin, y, thickness) =
-abs(margin - thickness) * 2 + get_y_count(radius, margin, y + abs(margin - thickness) * 2) * get_tile_height(radius, margin);


module hexagon(radius=1) {
	translate([radius, radius * cos(30), 0]) circle(radius, $fn=6);
}

module hexplane(radius=1, margin=0.5, x=10, y=10, underflow=false, overflow=false) {
    tile_width = get_tile_width(radius, margin);
    x_step = get_x_step(radius, margin);
    y_step = get_tile_height(radius, margin);
    x_underflow = underflow ? x_step : 0;
    y_underflow = underflow ? y_step : 0;
    x_overflow = overflow ? x_step : 0;
    y_overflow = overflow ? y_step : 0;
    for (x = [-x_underflow: x_step: x + x_overflow - get_x_margin(margin) - tile_width / 2]) {
	for (y = [-y_underflow: y_step: y + y_overflow - get_hex_height(radius)]) {
	    translate([x, y, 0]) hexagon(radius);
	}
    }
}

module hexfield(radius=1, margin=0.5, x=10, y=10, overflow=true) {
    x_offset = get_x_step(radius, margin) / 2;
    y_offset = get_tile_height(radius, margin) / 2;
    hexplane(radius, margin, x - x_offset, y, overflow=overflow);
    translate([-x_offset, -y_offset, 0])
    hexplane(radius, margin, x, y + y_offset, overflow=overflow);
}



module hexface(radius=1, margin=0.5, x=10, y=10, thickness=1, x_offset=0, y_offset=0) {
    hex_x = get_hex_x(radius, margin, x, thickness);
    hex_y = get_hex_y(radius, margin, y, thickness);
    difference() {
        cube([hex_x, hex_y, thickness]);
	translate([x_offset + thickness, y_offset + thickness, 0]) linear_extrude(height=thickness) hexfield(radius, margin, hex_x, hex_y);
    }
}
