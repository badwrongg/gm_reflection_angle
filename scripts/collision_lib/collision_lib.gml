// Some collision functions to add to your existing collision library of functions

/// @function					get_collision_mask_rotated_rect(_id)
/// @description				Calculates the vertices for a rotated-rectangle collision mask
/// @param {Id.Instance} _id	The id of the instance
/// @return {Array}				A flattened array of vertices [0 - 7] 
function get_collision_mask_rotated_rect(_id)
{
	with (_id)
	{
		var _x = (bbox_left + bbox_right) * 0.5, _y = (bbox_top + bbox_bottom) * 0.5,
			_w = (sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index)) * image_xscale * 0.5, 
			_h = (sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index)) * image_yscale * 0.5, 
			_cos = dcos(image_angle), _sin = -dsin(image_angle),
			_wcos = _w * _cos, _wsin = _w * _sin,
			_hcos = _h * _cos, _hsin = _h * _sin;
			
		return [_x - _wcos + _hsin, _y - _wsin - _hcos,
				_x + _wcos + _hsin, _y + _wsin - _hcos,
				_x + _wcos - _hsin, _y + _wsin + _hcos,
				_x - _wcos - _hsin, _y - _wsin + _hcos];
	}
}

/// @function					collision_line_point_normal(_x1, _y1, _x2, _y2, _obj)
/// @description				Finds the point of collision and normal vector 
/// @param {Real} _x1			The x coordinate of the start of the line
/// @param {Real} _y1			The y coordinate of the start of the line
/// @param {Real} _x2			The x coordinate of the end of the line
/// @param {Real} _y2			The y coordinate of the end of the line
/// @param {Asset.GMObject}		The object (or id) to check for
/// @return {Array}				Returns an array [0 - 3] with collision point and normal, or noone
function collision_line_point_normal(_x1, _y1, _x2, _y2, _obj)
{
	var _inst = collision_line(_x1, _y1, _x2, _y2, _obj, true, true);
	
	if (_inst == noone)
	{
		return noone;
	}

	var _verts = get_collision_mask_rotated_rect(_inst),
		_i = 0, _len = array_length(_verts),
		_ax = _verts[_len - 2], _ay = _verts[_len - 1],
		_bx = 0, _by = 0,
		_cx = infinity,	_cy = infinity,
		_nx = infinity,	_ny = infinity,
		_min_dist = infinity;
	
	// Loops through line segments AB to find intersection
	while (_i < _len)
	{
		_bx = _verts[_i++];
		_by = _verts[_i++];
		
	    var _s1_x = _x2 - _x1, _s1_y = _y2 - _y1,
			_s2_x = _bx - _ax, _s2_y = _by - _ay,
			_s = (-_s1_y * (_x1 - _ax) + _s1_x * (_y1 - _ay)) / (-_s2_x * _s1_y + _s1_x * _s2_y),
			_t = ( _s2_x * (_y1 - _ay) - _s2_y * (_x1 - _ax)) / (-_s2_x * _s1_y + _s1_x * _s2_y);

	    if (_s >= 0 && _s <= 1 && _t >= 0 && _t <= 1)
	    {
	        // Intersection detected
			var _tx = _x1 + _t * _s1_x, _ty = _y1 + _t * _s1_y,
				_vx = _tx - _x1, _vy = _ty - _y1,
				_dist = _vx * _vx + _vy * _vy; // only need squared distance here
			
			// Only want the closest intersection
			if (_dist < _min_dist)
			{
				_min_dist = _dist;
				_cx = _tx;
				_cy = _ty;
				_nx = _by - _ay;
				_ny = -(_bx - _ax);
			}
	    }
		
		_ax = _bx;
		_ay = _by;
	}

	if (_min_dist < infinity)
	{
		return [_cx, _cy, _nx, _ny];	
	}
	
	return noone;
}