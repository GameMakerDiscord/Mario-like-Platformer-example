/// @description Insert description here
// You can write your code in this editor
var _tilemap = obj_controller.tilemap;
if (place_meeting(x,y,par_box) || scr_tilemap_box_collision(_tilemap,bbox_left,bbox_top,bbox_right,bbox_bottom,true)) {
	y -= 2;
} else {
	active = true;	
}