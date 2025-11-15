/// @description Player ongoing settings
// Player input

key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);

// Calculate movement
var _move = key_right - key_left;

x_speed = _move * walk_speed;
y_speed = y_speed + grav;




//Collision (x)
if (place_meeting(x+x_speed,y,obj_wall))
{
	while (!place_meeting(x+sign(x_speed),y,obj_wall))
	{
		x = x + sign(x_speed);	
	}	
	x_speed = 0;
}	
	
x = x + x_speed;

//Collision (y)
if (place_meeting(x,y+y_speed,obj_wall))
{
	while (!place_meeting(x,y+sign(y_speed),obj_wall))
	{
		y = y + sign(y_speed);	
	}	
	y_speed = 0;
}	
	
y = y + y_speed;
