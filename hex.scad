function get_tile_width(radius, margin) = 2 * (radius + margin) + margin;
function get_tile_height(radius, margin) = 2 * (radius + margin) * cos(30);
function get_x_step(radius, margin) = get_tile_width(radius, margin) + radius;
function get_y_step(radius, margin) = get_tile_height(radius, margin);
function get_hex_x(radius, margin, x) = ceil(x / get_tile_width(radius, margin)) * get_tile_width(radius, margin);
function get_hex_y(radius, margin, y) = ceil(y / get_tile_height(radius, margin)) * get_tile_height(radius, margin);


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
    for (x = [-x_underflow: x_step: x + x_overflow]) {
	for (y = [-y_underflow: y_step: y + y_overflow]) {
	    translate([x, y, 0]) hexagon(radius);
	}
    }
}

module hexfield(radius=1, margin=0.5, x=10, y=10, overflow=false) {
    hexplane(radius, margin, x, y, overflow);
    x_offset = get_x_step(radius, margin) / 2;
    y_offset = get_tile_height(radius, margin) / 2;
    translate([x_offset, y_offset, 0])
    hexplane(radius, margin, x - x_offset, y - y_offset, underflow=true, overflow=false);
}



module hexface(radius=1, margin=0.5, x=10, y=10) {
    x = get_hex_x(radius, margin, x);
    y = get_hex_y(radius, margin, y);
    difference() {
        cube([x, y, margin]);
	translate([margin, margin * cos(30), 0]) linear_extrude(height=margin + 1) hexfield(radius, margin, x, y);
    }
}
