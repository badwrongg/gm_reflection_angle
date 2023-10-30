// Some vector 2 functions (we use arrays because structs waste memory for simple data container usage)

// Macro
#macro VX 0					// Index the x component of a vec2
#macro VY 1					// Index the y component of a vec2
#macro NX 2					// Index x component of a normal in an array of vec2 plus normal
#macro NY 3					// Index y component of a normal in an array of vec2 plus normal
#macro DIV_BY_ZERO -4		// Only Chuck Norris can divide by zero

/// @function			vec2_reflect(_ix, _iy, _nx, _ny)
/// @description		Finds the reflection vector
/// @param {Real}		The x component of the incident vector
/// @param {Real}		The y component of the indicent vector
/// @param {Real}		The x component of the normal vector (normalized)
/// @param {Real}		The y component of the normal vector (normalized)
/// @return {Array}		The reflected vector in an array [0 - 1]
function vec2_reflect(_ix, _iy, _nx, _ny)
{
	// Reflection vector: I - 2.0 * dot_product(N, I) * N
	// https://registry.khronos.org/OpenGL-Refpages/gl4/html/reflect.xhtml
	var _dot = dot_product(_nx, _ny, _ix, _iy);
	return [_ix - 2 * _dot * _nx, _iy - 2 * _dot * _ny];
}

/// @function			vec2_safe_normalize(_vx, _vy)
/// @description		Normalizes a vector 2 and avoids division by zero
/// @param {Real}		The x component of the vector
/// @param {Real}		The y component of the vector
/// @return {Array}		A vector 2 array or DIV_BY_ZERO
function vec2_safe_normalize(_vx, _vy)
{
	var _sqdist = _vx * _vx + _vy * _vy;
	
	if (_sqdist == 0)
	{
		return DIV_BY_ZERO;
	}
	
	_sqdist = sqrt(_sqdist);
	return [_vx / _sqdist, _vy / _sqdist];
}