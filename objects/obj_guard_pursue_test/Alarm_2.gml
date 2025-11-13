/// @description ALERT to ATTACK state if Player found
// You can write your code in this editor
 if spotted == true { 
	// Play sound
    audio_play_sound(snd_laser_gun, 1, false);
	obj_player.player_health -= 1;
	alarm_triggered = false;
}