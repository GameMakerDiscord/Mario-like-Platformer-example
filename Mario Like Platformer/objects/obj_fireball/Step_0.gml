/// @description 
yspeed += gravity_strength;
yspeed = clamp(yspeed,-max_yspeed,max_yspeed);

angle++;

var _inst = instance_place(x,y,par_enemy);
if (_inst != noone) {
	_inst.hp -= 1;			// damage enemy
	instance_destroy();
}

f_xspeed = floor(xspeed);
f_yspeed = floor(yspeed);

if (!scr_collide_with_world(	tilemap,
								bbox_left+f_xspeed, bbox_top,
								bbox_right+f_xspeed, bbox_bottom, par_box)) {
	x += f_xspeed;
}
else {
	instance_destroy();	
}
if (!scr_collide_with_world(	tilemap,
								bbox_left, bbox_top+f_yspeed,
								bbox_right, bbox_bottom+f_yspeed, par_box)) {
	y += f_yspeed;
}
else {
	while (!scr_collide_with_world(	tilemap,
									bbox_left, bbox_top+sign(f_yspeed),
									bbox_right, bbox_bottom+sign(f_yspeed), par_box)) {
		y += sign(f_yspeed);
	}
	yspeed = -max_yspeed*sign(yspeed);
}