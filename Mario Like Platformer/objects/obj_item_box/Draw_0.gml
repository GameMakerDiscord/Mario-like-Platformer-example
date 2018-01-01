/// @description Insert description here
// You can write your code in this editor
var _yoff = 0;
if (alarm[0] != -1) {
	_yoff = -dsin(180*(alarm[0]/6) )*16;
}

draw_sprite_ext(spr_itembox,image_index,x,y+_yoff,1,1,0,c_white,1);