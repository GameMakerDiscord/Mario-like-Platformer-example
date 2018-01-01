/// @description Insert description here
// You can write your code in this editor

#region Platforming bits

var _lr = keyboard_check(vk_right)-keyboard_check(vk_left);
var _jumpkey = keyboard_check_pressed(ord("X"));
var _jumpkey_held = keyboard_check(ord("X"));
xspeed += _lr;
xspeed += -sign(xspeed)*friction_strength; 		//	applying basic friction
xspeed = clamp(xspeed,-max_xspeed,max_xspeed);	//	limiting speed
if (abs(xspeed)) < 0.2 {
	xspeed = 0;
}
yspeed += gravity_strength;
yspeed = clamp(yspeed,-max_yspeed,max_yspeed);

f_xspeed = floor(xspeed);
f_yspeed = floor(yspeed);
/*
var _inBlock = scr_tilemap_box_collision(	obj_controller.tilemap,
											bbox_left,	bbox_top,
											bbox_right,	bbox_bottom, true);
*/
var _inBlock = scr_collide_with_world(	obj_controller.tilemap, x, y,
										bbox_left, bbox_top, bbox_right, bbox_bottom, par_box);
if (_inBlock) {
	var _xd = 0;
	/*_inBlock = scr_tilemap_box_collision(	obj_controller.tilemap,
											bbox_left + _xd,	bbox_top,
											bbox_right + _xd,	bbox_bottom, true);
	*/
	show_debug_message("in block check");
	_inBlock = scr_collide_with_world(	obj_controller.tilemap, x + _xd, y,
										bbox_left + _xd, bbox_top, bbox_right + _xd, bbox_bottom, par_box);
	while (_inBlock) {
		_xd += 1;
	}
}
/*var _grounded = scr_tilemap_box_collision(	obj_controller.tilemap,
								bbox_left,	bbox_bottom+1,
								bbox_right,	bbox_bottom+1 , true)
*/
var _grounded = scr_collide_with_world(	obj_controller.tilemap, x, y+1,
										bbox_left, bbox_bottom+1, bbox_right, bbox_bottom+1, par_box);
show_debug_message("grounded check");
if (!scr_collide_with_world(	obj_controller.tilemap, x+f_xspeed, y,
								bbox_left+f_xspeed, bbox_top, bbox_right+f_xspeed, bbox_bottom, par_box)) {
	x += f_xspeed;
	show_debug_message("x-movement");
}
else {
	while (!scr_collide_with_world(	obj_controller.tilemap, x+sign(f_xspeed), y,
									bbox_left+sign(f_xspeed), bbox_top, bbox_right+sign(f_xspeed), bbox_bottom, par_box))  {
		x += sign(f_xspeed);
		show_debug_message("x-to-block");
	}
	xspeed = 0;
}
if (!scr_collide_with_world(	obj_controller.tilemap, x, y+f_yspeed,
								bbox_left, bbox_top+f_yspeed, bbox_right, bbox_bottom+f_yspeed, par_box)) {
	y += f_yspeed;
	show_debug_message("y-movement");
}
else {
	while (!scr_collide_with_world(	obj_controller.tilemap, x, y+sign(f_yspeed),
									bbox_left, bbox_top+sign(f_yspeed), bbox_right, bbox_bottom+sign(f_yspeed), par_box)) {
		y += sign(f_yspeed);
		show_debug_message("y-move-check");
	}
	yspeed = 0;
}
show_debug_message("Moved successfully")
if (_grounded) {
	if (_jumpkey) {
		yspeed = -jumpspeed;
	}
} else if (yspeed < -2 && _jumpkey_held) { //still going up
	yspeed -= 1;
}
#endregion

#region Item Collisions

var _inst = instance_place(x,y,par_item);
if (instance_exists(_inst)) {
	if (_inst.active == true) {
		switch(_inst.object_index) {
			case obj_item_mushroom:
				if (form == player_forms.small) {
					form = player_forms.big;	
				}
			break;
			case obj_item_gem:
				form = player_forms.fire;
			break;
		}
		instance_destroy(_inst);
	}
}
#endregion

#region Animation bits

if (state != player_states.climb) {
	if (!_grounded) {
		state = player_states.jump;	
	}
	else {
		state = player_states.idle;
		if (abs(f_xspeed) > 0.5) {
			state = player_states.run;
			image_speed = (f_xspeed/max_xspeed)/3;
		}
	}
}

var _idle, _run, _jump, _climb;
switch (form) {
	case player_forms.small: 
		mask_index = spr_player_small_mask;
		_idle = spr_player_small_idle;
		_run = spr_player_small_run;
		_jump = spr_player_small_jump;
		_climb = spr_player_small_climb;
	break;
	case player_forms.big: 
		mask_index = spr_player_big_mask;
		_idle = spr_player_big_idle;
		_run = spr_player_big_run;
		_jump = spr_player_big_jump;
		_climb = spr_player_big_climb;
	break;	
	case player_forms.fire: 
		mask_index = spr_player_big_mask;
		_idle = spr_player_fire_idle;
		_run = spr_player_fire_run;
		_jump = spr_player_fire_jump;
		_climb = spr_player_fire_climb;
	break;
}
switch (state) {
	case player_states.idle: 
		sprite_index = _idle;
	break;
	case player_states.run: 
		sprite_index = _run;
	break;
	case player_states.jump:
		sprite_index = _jump;
	break;
	case player_states.climb:
		sprite_index = _climb;
	break;
}
//Set image xscale based on direction
image_xscale = sign(f_xspeed) == 0 ?  image_xscale : sign(f_xspeed);
#endregion

#region Camera

var _cam = view_camera[0];
var _camw = camera_get_view_width(_cam);
var _camh = camera_get_view_height(_cam);
var _camx = x - ( _camw/2 - _camw/12 * sign(image_xscale));
var _camy = y - _camh*(2/4);
var _old_x = clamp(camera_get_view_x(_cam),0,room_width-_camw);
var _old_y = clamp(camera_get_view_y(_cam),0,room_height-_camh);

_camx = clamp(_camx,0,room_width-_camw);
_camy = clamp(_camy,0,room_height-_camh);
var _perc = 0.5;
camera_set_view_pos(_cam,lerp(_old_x,_camx,_perc),lerp(_old_y,_camy,_perc));

#endregion

#region Debug
//*/

if (keyboard_check_pressed(ord("B"))) {
	form = (form == player_forms.small) ? player_forms.big : player_forms.small;	
}

//*/
#endregion