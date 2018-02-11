/// @description 
if (hp <= 0) {
	image_yscale = 0.25;
	if (alarm[0] == -1) {
		alarm[0] = game_get_speed(gamespeed_fps)*0.5;	
	}
	exit;
}
yspeed += gravity_strength;
f_xspeed = floor(xspeed);
f_yspeed = floor(yspeed);
if (!scr_collide_with_world(	obj_controller.tilemap,
								bbox_left+f_xspeed, bbox_top,
								bbox_right+f_xspeed, bbox_bottom, par_box)) {
	x += f_xspeed;
}
else {
	while (!scr_collide_with_world(	obj_controller.tilemap, 
									bbox_left+sign(f_xspeed), bbox_top,
									bbox_right+sign(f_xspeed), bbox_bottom, par_box))  {
		x += sign(f_xspeed);
	}
	xspeed = -xspeed;		//turn around when hitting a wall
}
if (!scr_collide_with_world(	obj_controller.tilemap,
								bbox_left, bbox_top+f_yspeed,
								bbox_right, bbox_bottom+f_yspeed, par_box)) {
	y += f_yspeed;
}
else {
	while (!scr_collide_with_world(	obj_controller.tilemap,
									bbox_left, bbox_top+sign(f_yspeed),
									bbox_right, bbox_bottom+sign(f_yspeed), par_box)) {
		y += sign(f_yspeed);
	}
	yspeed = 0;
}

image_xscale = sign(xspeed);