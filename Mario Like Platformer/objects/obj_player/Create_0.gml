/// @description Initialisation
enum player_states {
	idle,
	run,
	jump,
	climb
}
enum player_forms {
	small,
	big,
	fire
}
state = player_states.idle;
form = player_forms.small;

xspeed = 0;
yspeed = 0;

f_xspeed = 0;
f_yspeed = 0;

max_xspeed = 6;
max_yspeed = 30;

jumpspeed = 20;

gravity_strength = 1.5;
friction_strength = 0.5;

mask_index = spr_player_small_mask;

