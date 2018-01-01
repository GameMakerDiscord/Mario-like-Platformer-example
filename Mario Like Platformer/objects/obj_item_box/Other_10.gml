/// @description Spawn the items
// TODO: spawn relevant items/do shit
if (active== true) {
	active = false;
	var _obj;
	switch (item) {
		case items.mushroom: 
			_obj = obj_item_mushroom;
		break;
		case items.gem:
			_obj = obj_item_gem;
		break;
		case items.multi_coin:
			coins -= 1;
			_obj = obj_item_coin;
		break;
		case items.coin:
			_obj = obj_item_coin;
		break;
		case items.mushroom_or_gem:
			_obj = (obj_player.form == player_forms.small) ? obj_item_mushroom : obj_item_gem;
		break;
	
	}
	var _inst = instance_create_layer(x + sprite_width/2,y + sprite_height/2,"Items",_obj);
	alarm[0] = room_speed*0.1;		// Timer for slight bump
}
if (item != items.multi_coin || (item == items.multi_coin && coins <= 0)) {
	image_index = 1;
}

