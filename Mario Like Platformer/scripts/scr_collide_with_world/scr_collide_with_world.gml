///@desc scr_collide_with_world
///@arg {real} tilemap
///@arg {real} x
///@arg {real} y
///@arg {real} x1
///@arg {real} y1
///@arg {real} x2
///@arg {real} y2
///@arg {object} box_parent
var _tilemap = argument[0],
	_x = argument[1],
	_y = argument[2],
	_x1 = argument[3],
	_y1 = argument[4],
	_x2 = argument[5],
	_y2 = argument[6],
	_obj = argument[7];


var _col = false;
_col = scr_tilemap_box_collision(_tilemap, _x1, _y1, _x2, _y2, false);
var _w = _x2-_x1;

var _inst = /* instance_place(_x,_y,_obj); // */  collision_rectangle(_x1,_y1,_x2,_y2,_obj,false,true);
if (!instance_exists(_inst)) {		//early exit
	show_debug_message("early exit - no instances of " + object_get_name(_obj) + " found");
	return _col;
}

var _inst = collision_rectangle(_x1+(_w/2),_y1,_x2-(_w/2),_y2,_obj,false,true);
if (!instance_exists(_inst)) {
	show_debug_message("no box to headbutt, exiting");
	return _col;
}
//handle item boxes
show_debug_message("pre-box check");

if ( (yspeed <= 0) && (_y1 > _inst.bbox_bottom-5) ) {		//if below the box with a slight buffer
	with (_inst) {
		show_debug_message("box found! executing");
		event_user(0);	
	}
}
return (_inst);