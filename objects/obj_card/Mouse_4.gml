///allow flipping if only 1 card selected
if !point_in_rectangle(mouse_x, mouse_y, x, y, x + sprite_width, y + sprite_height) {
    exit; 
}

if !flipped && global.plays<2
{
	flipped = true;
	ds_list_add(global.selected, id);
	audio_play_sound(snd_Cardflip, 1, false);
	global.plays++;
}