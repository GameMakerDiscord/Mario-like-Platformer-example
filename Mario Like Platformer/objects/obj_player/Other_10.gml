/// @description Got hit by an enemy
if (invincibility <= 0) {
	switch (form) {
		case player_forms.fire:
			form = player_forms.big;
		break;
		case player_forms.big:
			form = player_forms.small;
		break;
		case player_forms.small:
			xspeed = 0;
			yspeed = -15;
			gravity_strength = 0.25;
			image_speed = 0;
			dead = true;
		break;
	}
	invincibility = game_get_speed(gamespeed_fps)*1; // 1 second invincibility
}