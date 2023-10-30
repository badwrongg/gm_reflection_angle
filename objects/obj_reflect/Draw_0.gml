var _point_norm = collision_line_point_normal(x, y, mouse_x, mouse_y, obj_box);
if (_point_norm != noone)
{
	var _px = _point_norm[VX], _py = _point_norm[VY],
		_normal = vec2_safe_normalize(_point_norm[NX], _point_norm[NY]),
		_reflect = vec2_reflect(_px - x, _py - y, _normal[VX], _normal[VY]);
	
	// Incident vector
	draw_line(x, y, _px, _py);
	
	// Normal vector from collision point
	draw_line_color(_px, _py, _px + _normal[VX] * 40, _py + _normal[VY] * 40, c_blue, c_blue);
	
	// Reflection vector from collision point
	draw_line_color(_px, _py, _px + _reflect[VX], _py + _reflect[VY], c_yellow, c_yellow);
}
else
{
	draw_line(x, y, mouse_x, mouse_y);	
}

draw_self();