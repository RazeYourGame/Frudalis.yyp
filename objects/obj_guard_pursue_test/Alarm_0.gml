// Alarm[0] only fires if we have gone 4 seconds *without* seeing the player
// If we get here, we must not currently be spotting the player
if spotted == false {
	last_known_x = obj_player.x;
    my_state = GUARD_STATE.PURSUE;
	alarm_triggered = false;
	
} else {
    // Safety: if somehow still true, keep pausing
    alarm[0] = reaction_time;
}