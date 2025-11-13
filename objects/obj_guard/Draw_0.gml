/// @description Visual cone testing

// Draw the enemy sprite
draw_self();


var facing = sign(image_xscale); // 1 = right, -1 = left

// Start and end of the rectangle along the X axis
var x_start = x;
var x_end = x + vision_range * facing;

// Top and bottom of the rectangle (Y axis, vertically centred)
var y_top = y - vision_width;
var y_bottom = y;

// Four corners of the rectangle
var p1x = x_start;
var p1y = y_top;

var p2x = x_start;
var p2y = y_bottom;

var p3x = x_end;
var p3y = y_bottom;

var p4x = x_end;
var p4y = y_top;

if spotted = false
	{
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_colour(p1x, p1y, c_yellow, 0.1);
	draw_vertex_colour(p2x, p2y, c_yellow, 0.1);
	draw_vertex_colour(p4x, p4y, c_yellow, 0.1);
	draw_vertex_colour(p3x, p3y, c_yellow, 0.1);
	draw_primitive_end();
	}
	else
	{
	draw_primitive_begin(pr_trianglestrip);
	draw_vertex_colour(p1x, p1y, c_red, 0.1);
	draw_vertex_colour(p2x, p2y, c_red, 0.1);
	draw_vertex_colour(p4x, p4y, c_red, 0.1);
	draw_vertex_colour(p3x, p3y, c_red, 0.1);
	draw_primitive_end();
	}

