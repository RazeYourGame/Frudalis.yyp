/// @description ATTACK shot resolution

if (spotted && instance_exists(obj_player)) {
    // Still see the player at the moment of firing – take the shot
    audio_play_sound(snd_laser_gun, 1, false);

    // Apply your existing damage logic here
    obj_player.player_health -= 1;

    // Reset for next encounter
    can_fire = true;
    alarm_triggered = false;

    // If your damage system destroys the player on 0 HP,
    // you can branch here if you like:
    if (!instance_exists(obj_player)) {
        // Player died – go back to patrol
        my_state = GUARD_STATE.PATROL;
    } else {
        // Player somehow survived – stay alert/attack
        my_state = GUARD_STATE.ALERT;
    }
} else {
    // Lost sight before we could shoot: switch to PURSUE
    if (instance_exists(obj_player)) {
        last_known_x = obj_player.x;
    }
    my_state = GUARD_STATE.PURSUE;
    can_fire = true;
    alarm_triggered = false;
}