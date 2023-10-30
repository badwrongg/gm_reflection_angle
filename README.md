# gm_reflection_angle
Angle reflection implemented in GML

The function - vec2_reflect: https://github.com/badwrongg/gm_reflection_angle/blob/main/scripts/vec2_lib/vec2_lib.gml

Calculating a reflection direction is actually very simple, and here I used the GLSL implementation as reference.
However, the information needed to call this function is a bit more involved, and the project includes the other
functions and setup needed to understand how to obtain it.  Specifically, the collison normal is needed for the calculation
which requires calculating the precise collision point and edge hit on a collision mask with a raycast.  The other script 
file collision_lib.gml contains the extra functions needed.
