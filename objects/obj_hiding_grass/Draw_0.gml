/// @description Insert description here
// You can write your code in this editor

draw_self();

var fade_speed = 0.05; // How fast to fade (lower = slower)

if (place_meeting(x, y, obj_player)) {
    // Fade out to 0.7
    image_alpha = max(image_alpha - fade_speed, 0.7);
} else {
    // Fade back in to 1
    image_alpha = min(image_alpha + fade_speed, 1);
}