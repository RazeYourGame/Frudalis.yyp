/// @description Initial variables

// Movement and Gravity
// Movement and Gravity
x_speed = 0;
y_speed = 0;
grav = 0.3;
walk_speed = 1.5;
my_state = start_state;



// Enemy vision and alertness
vision_range = 1920;
vision_width = sprite_height * 1.5;
spotted = false; // Status of whether player has been spotted by enemy

// PURSUE TESTING BITS
home = spawn_x.x;        // Store the resting x position
last_known_x = x;
pause_time = reaction_time * 2;
// Determine patrol edges
x_left  = home - l_travel;
x_right = home + r_travel;


// Additional values for sprites and enemy WAIT status
alarm_triggered = false;
can_fire = true;
lost_sight_timer = 0;
lost_sight_delay = 60;

// Notes on variables found in Variable Definitions
//start_dir = 1; // Direction that enemy spawns facing in (1 = right, -1 = left)
//r_travel = 300; // Distance enemy travels right during patrol along x axis
//l_travel = 30; // Distance enemy travels left during patrol along x axis
//wait_duration = 120; // Length of time enemy pauses between movement
//current_dir = 1; // Direction that enemy is actively travellijng in ((1 = right, -1 = left)
//spawn_x = inst_C4FD579.x; // Spawn point of enemy based on of local obj_spawner instance
//reaction_time = 60; // Length of time enemy waits before attacking

