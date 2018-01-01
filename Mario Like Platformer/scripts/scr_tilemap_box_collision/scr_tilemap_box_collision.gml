/// @desc scr_tilemap_box_collision
/// @arg tilemap
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg [precision*2]
var _tilemap = argument[0],
	_x1 = argument[1],
	_y1 = argument[2],
	_x2 = argument[3],
	_y2 = argument[4];

var _p = array_create(9,0);
_p[0]= tilemap_get_at_pixel(_tilemap,_x1,_y1);
_p[1] = tilemap_get_at_pixel(_tilemap,_x2,_y1);
_p[2] = tilemap_get_at_pixel(_tilemap,_x2,_y2);
_p[3] = tilemap_get_at_pixel(_tilemap,_x1,_y2);
var _xh = (_x1 + _x2)/2;
var _yh = (_y1 + _y2)/2;

if (argument_count == 6) {
	if (argument[5]) {
		_p[4] = tilemap_get_at_pixel(_tilemap,_xh,_y1);
		_p[5] = tilemap_get_at_pixel(_tilemap,_xh,_y2);
		_p[6] = tilemap_get_at_pixel(_tilemap,_x1,_yh);
		_p[7] = tilemap_get_at_pixel(_tilemap,_x2,_yh);
		_p[8] = tilemap_get_at_pixel(_tilemap,_xh,_yh);		//centre as well
	}
}

var _i = 0, _s = 0;
while (_i < 4 + 4*(argument_count == 6)) {
	_s += _p[_i++];
}
return (sign(_s));