///check cards
if ds_list_size(global.selected) == 2 //check if 2 cards selected
{
	if global.selected[|0].sprite_index == global.selected[|1].sprite_index //check if cards match
	{
		//if matched
		ds_list_clear(global.selected);
		goes--;
		global.plays = 0;
		matches++;
	}
	else
	{
		//if not matched
		card1 = global.selected[|0].id;
		card2 = global.selected[|1].id;
		ds_list_clear(global.selected);
		goes--;
		alarm[0] = room_speed;
	}
}

//check for game end
if goes==0
{
	show_message("You Lose");
	room_restart();
}

if matches == 3
{
	show_message("You Win");
	room_goto(school_day1_scene1);
}
		