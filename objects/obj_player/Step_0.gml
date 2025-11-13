/// @description Player ongoing settings
// Player input

key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);

// Calculate movement
var _move = key_right - key_left;
var _climb = key_up - key_down;

x_speed = _move * walk_speed;
y_speed = y_speed + grav;

if key_jump
	{
	player_health -= 1;
	}

if (player_health <= 0)
	{
    instance_destroy(obj_player);
    room_restart();
	}
	
// Jump (but not for Player)
//if (place_meeting(x,y+1,obj_wall)) && (key_jump)
//{
//	y_speed = -10;
//}

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


//Wire collision
if place_meeting(x,y,obj_wire) {
	on_wire = true;
} else {
	on_wire = false;
}

if on_wire = true {
	//Negate gravity
	y_speed = 0;
	grav = 0;
	
	if (_climb == 1) y_speed = -2;
	if (_climb == -1) y_speed = 2;
} else {
	grav = 0.3;
}	

// Determine if player is hiding
if place_meeting(x, y, obj_stealth_area) {
	player_visible = false;
} else {
	player_visible = true;
}

//Animation
if (!place_meeting(x,y+1,obj_wall))
{
	sprite_index = spr_player_air;
	image_speed = 0;
	if (sign(y_speed) > 0) image_index = 1; else image_index = 0;
}
else
{
	image_speed = 1;
	if (x_speed == 0)
	{
		sprite_index = spr_player;
	}	
	else
	{
		sprite_index = spr_player_run;
	}
}


