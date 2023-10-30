if (keyboard_check_pressed(vk_escape))
{	
	game_end();
}	

var _x_axis = keyboard_check(ord("D")) - keyboard_check(ord("A")),
	_y_axis = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	
if (_x_axis != 0 || _y_axis != 0)
{
	var _dir = arctan2(_y_axis, _x_axis);
	x += cos(_dir) * 4;
	y += sin(_dir) * 4;
}