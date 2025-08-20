///allow flipping if only 1 card selected
show_debug_message("Left Pressed Event Triggered");
show_debug_message("Flipped!");

if !point_in_rectangle(mouse_x, mouse_y, x, y, x + sprite_width, y + sprite_height) {
    exit; // don’t flip if click wasn’t inside this card
}

if !flipped && global.plays<2
{
	flipped = true;
	ds_list_add(global.selected, id); //add id to the list
	global.plays++;//mark as selection made
}