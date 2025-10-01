// In obj_interactive_door -> Step Event

// First, check if the player object is colliding with this door.
// We use place_meeting, which is a common way to check for collisions.
if (place_meeting(x, y - 10, obj_MC)) {
    player_is_close = true;
} else {
    player_is_close = false;
}

// Now, if the player IS close and they press the 'E' key...
// keyboard_check_pressed ensures this only fires once per key press.
if (player_is_close && keyboard_check_pressed(ord("E"))) {
    
    // Go to the specified room.
    room_goto(room_Day1_Scene2);
}

