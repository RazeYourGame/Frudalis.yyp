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

if spotted == false
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





/// --- DRAW EVENT (add this AFTER drawing the sprite) ---

// 1. Define the weak spot rectangle in LOCAL coords (relative to enemy origin)
var local_x1 = -45;
var local_x2 =  45;
var local_y1 = -sprite_height + 60// a bit above the top of sprite
var local_y2 = -sprite_height - 60// small vertical band

// If the enemy flips horizontally, factor this in:
local_x1 *= current_dir;
local_x2 *= current_dir;

// 2. Convert to ROOM (world) coords
var rx1 = x + local_x1;
var rx2 = x + local_x2;
var ry1 = y + local_y1;
var ry2 = y + local_y2;

// Normalise ordering (just in case)
var x1 = min(rx1, rx2);
var x2 = max(rx1, rx2);
var y1 = min(ry1, ry2);
var y2 = max(ry1, ry2);

// 3. DRAW the rectangle
draw_set_alpha(0.4);            // slightly transparent fill
draw_set_color(c_aqua);         // or any colour you want
draw_rectangle(x1, y1, x2, y2, false);

// Draw a stronger outline
draw_set_alpha(1);
draw_set_color(c_teal);
draw_rectangle(x1, y1, x2, y2, true);

// Reset draw state
draw_set_alpha(1);
draw_set_color(c_white);