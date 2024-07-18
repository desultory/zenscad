function get_tile_width(radius, margin) = 2 * (radius + margin);
function get_tile_height(radius, margin) = 2 * radius * cos(30) + margin;
function get_x_step(radius, margin) = get_tile_width(radius, margin) + radius / 2;
function get_y_step(radius, margin) = get_tile_height(radius, margin);


module hexplane(radius=1, margin=0.5, x_width=10, y_width=10,
    underflow=false, overflow=false) {
    tile_width = get_tile_width(radius, margin);
    x_step = get_x_step(radius, margin);
    y_step = get_tile_height(radius, margin);
    x_underflow = underflow ? x_step : 0;
    y_underflow = underflow ? y_step : 0;
    x_offset = radius - x_underflow;
    y_offset = radius * cos(30) - y_underflow;
    limit = overflow ? 0 : radius;
    for (x = [x_offset: x_step: x_width - limit]) {
	for (y = [y_offset: y_step: y_width - limit]) {
	   translate([x, y, 0])
	   circle(radius, $fn=6);
	}
    }
}

module hexfield(radius=1, margin=0.5, x_width=10, y_width=10, overflow=false) {
    hexplane(radius, margin, x_width, y_width, overflow);
    x_offset = get_x_step(radius, margin) / 2;
    y_offset = get_tile_height(radius, margin) / 2;
    translate([x_offset, y_offset, 0])
    hexplane(radius, margin, x_width - x_offset, y_width - y_offset, underflow=true, overflow=true);
}

