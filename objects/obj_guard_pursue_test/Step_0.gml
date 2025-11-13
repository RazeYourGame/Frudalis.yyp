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







switch my_state {
	
	case GUARD_STATE.PATROL:
	
	// Move based on direction
	x += current_dir * x_speed;

	// Flip sprite (optional)
	image_xscale = current_dir;

	// Hit right edge
        if (x >= x_right) {
            x = x_right;
            current_dir = -1;                
			alarm[1] = wait_duration; 
            my_state = GUARD_STATE.WAIT;                   
        }
    // Hit left edge
        else if (x <= x_left) {
            x = x_left;
            current_dir = 1;       
			alarm[1] = wait_duration;
            my_state = GUARD_STATE.WAIT;                    
        }
		
		
	
	if spotted == true
		{
		my_state = GUARD_STATE.ALERT;
		}
	
	break;
	
	case GUARD_STATE.WAIT:
       
	   if spotted == true
		{
		my_state = GUARD_STATE.ALERT;
		alarm[1] = -1;
		}
	   
    break;
	
	
	case GUARD_STATE.ALERT:
	
	if alarm_triggered == false && spotted == true
	{
	alarm_triggered = true;
	alarm[0] = pause_time;
	}
	
	break;
	
	
	case GUARD_STATE.ATTACK:
    // Face the player while attacking
    if (instance_exists(obj_player)) {
        image_xscale = sign(obj_player.x - x);
    }

    // If we no longer see the player, chase their last known position
    if (!spotted && instance_exists(obj_player)) {
        last_known_x = obj_player.x;
        my_state = GUARD_STATE.PURSUE;
        alarm_triggered = false;
        can_fire = true;
        alarm[2] = -1; // cancel any pending shot just in case
    }

    // If we DO see the player and haven't fired yet, schedule a shot
    if (spotted && can_fire) {
        can_fire = false;
        alarm[2] = 1; // fire next step
    }
break;
	
	
	case GUARD_STATE.PURSUE:
	
 // Move along X only toward last_known_x
	if (x != last_known_x) {
    if (x < last_known_x) {
        x += x_speed * 4; // move right
        if (x > last_known_x) x = last_known_x;
    } else {
        x -= x_speed * 4; // move left
        if (x < last_known_x) x = last_known_x;
    }
} else {
    // Arrived: return to idle status
    my_state = GUARD_STATE.RETURN;
}
    
	break;
	
	
case GUARD_STATE.RETURN:
    
    // If we see the player again while returning, go back to ALERT
    if (spotted == true) {
        my_state = GUARD_STATE.ALERT;
    }

    if (x != home) {
        if (x < home) {
            x += x_speed; // move right
            if (x > home) x = home;
        } else {
            x -= x_speed; // move left
            if (x < home) x = home;
        }
    } else {
        // Arrived: return to PATROL
        my_state = GUARD_STATE.PATROL;
    }

break;
}

var dx = x - xprevious;
if (dx != 0) image_xscale = sign(dx);

show_debug_message(my_state);