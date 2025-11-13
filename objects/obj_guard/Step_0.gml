/// @description Guard behaviours
// Movement and fall speeds
x_speed = walk_speed;
y_speed = y_speed + grav;

//Collision (x)
if (place_meeting(x, y, obj_wall)) {
    x_speed = 0;
}

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






switch my_state {
	case GUARD_STATE.PATROL:

	
// Move enemy and face direction of movement
x = x + x_speed * current_dir;
image_xscale = current_dir;

// Reverse direction if too far from spawn point

	if (x > spawn_x + r_travel || x < spawn_x - l_travel) 
		{
		my_state = GUARD_STATE.WAIT;
		wait_time = wait_duration;
		}

	if spotted == true
		{
		my_state = GUARD_STATE.ALERT;
		}

	break;

	case GUARD_STATE.WAIT:
        wait_time -= 1;

        if (wait_time <= 0) {
			current_dir *= -1;
            my_state = GUARD_STATE.PATROL;
        }
	
	if spotted == true
		{
		my_state = GUARD_STATE.ALERT;
		}
	
	break;
	
	case GUARD_STATE.ALERT:
	/// In obj_enemy Step Event or a firing script
	
	x_speed = 0;

	if instance_exists(obj_player) && spotted == true
		{
		// Play sound
		// audio_play_sound(snd_freeze);
		if alarm_triggered == false
			{
			alarm[0] = reaction_time;
			alarm_triggered = true; // Prevent it from resetting every step
			}
		}	
	
	if spotted == false
		{
		my_state = GUARD_STATE.PATROL;
		}
		
	break;
 }



// Always reset spotted to false when not being observed by enemy
spotted = false;

// Determine facing direction (1 = right, -1 = left)
var facing = sign(image_xscale); // or use your own facing variable if defined

if (instance_exists(obj_player)) {
    
    // Vector to player
    var dx = obj_player.x - x;
    var dy = obj_player.y - (y+50);

    // Check if player is in front of the sprite along the X axis
    var in_front = (facing == 1 && dx > 0) || (facing == -1 && dx < 0);
    var in_range = abs(dx) < vision_range;
    var within_vertical_bounds = dy >= -vision_width && dy <= 0;

    if (in_front && in_range && within_vertical_bounds && obj_player.player_visible == true) {

        // Line of sight check (cast from current position to player)
        if (!collision_line(x, y, obj_player.x-30, obj_player.y-60, obj_barrier, false, true)
		|| !collision_line(x, y, obj_player.x+30, obj_player.y-60, obj_barrier, false, true)){
			
            spotted = true;
        }
    }
}

