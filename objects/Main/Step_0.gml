/// @description Camera controls

var _view_id = 0;


// Check player exists and set coordinates
if (instance_exists(obj_player)) {
var _player_x = obj_player.x;
var _player_y = obj_player.y;
}

// Set camera coordinates
var _camera_x = camera_get_view_x(view_camera[_view_id]);
var _camera_y = camera_get_view_y(view_camera[_view_id]);

// Set camera position based on where player leaves screen
if obj_player.x >= _camera_x + 1920
	{
		camera_set_view_pos(view_camera[_view_id],_camera_x + 1920, _camera_y);
	}

	if obj_player.x <= _camera_x
	{
		camera_set_view_pos(view_camera[_view_id],_camera_x - 1920, _camera_y);
	}	

	if obj_player.y >= _camera_y +1080
	{
		camera_set_view_pos(view_camera[_view_id],_camera_x, _camera_y + 1080);
	}	

	if obj_player.y <= _camera_y
	{
		camera_set_view_pos(view_camera[_view_id],_camera_x, _camera_y - 1080);
	}	










