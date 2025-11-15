/// @description ALERT to PURSUE state change after reaction time.

if spotted == true {
    // We still see the player after pausing – go into ATTACK state
    my_state = GUARD_STATE.ATTACK;
} else {
    // Lost sight during the pause – pursue last known position instead
    if (instance_exists(obj_player)) {
        last_known_x = obj_player.x;
    }
    my_state = GUARD_STATE.PURSUE;
}

// Allow the ALERT logic to trigger again in future
alarm_triggered = false;
