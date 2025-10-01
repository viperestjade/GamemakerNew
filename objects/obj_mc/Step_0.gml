

// In obj_MC -> Step Event

// --- Automatic Cutscene Movement ---
// In obj_MC -> Step Event

// --- Automatic Cutscene Movement ---
if (is_moving_automatically) {
    // Calculate direction and distance to the target
    var _dir = point_direction(x, y, target_x, target_y);
    var _dist = point_distance(x, y, target_x, target_y);

    // Check if we still need to move
    if (_dist > cutscene_move_speed) {
        // --- 1. MOVE THE CHARACTER (Your Code) ---
        x += lengthdir_x(cutscene_move_speed, _dir);
        y += lengthdir_y(cutscene_move_speed, _dir);

        // --- 2. UPDATE THE ANIMATION (The Missing Part) ---
        // Change sprite based on the direction of movement
        if ((_dir >= 45) && (_dir < 135)) {
            sprite_index = spr_MCBW; 
        }
        else if ((_dir >= 135) && (_dir < 225)) {
            sprite_index = spr_MCLW;
        }
        else if ((_dir >= 225) && (_dir < 315)) {
            sprite_index = spr_MCFW;
        }
        else {
            sprite_index = spr_MCRW;
        }
    }
    // If we have arrived
    else {
        // --- 3. STOP AND FINALIZE ---
        x = target_x; // Snap to the final position
        y = target_y;
        is_moving_automatically = false; // Stop moving
        sprite_index = spr_MC_Idle; // Revert to an idle sprite
    }
    
    // Ignore regular player input while the cutscene is running
    exit;
}

// --- Regular Player Input Code ---
// (Your normal code for WASD movement goes here)
// --- Player Controlled Movement ---
// Only allow the player to move if a cutscene is NOT active AND the character is NOT moving automatically.
else if (!global.cutscene_active) {
	// In obj_MC -> Step Event

	// Check if the player is allowed to move.
	// This is only true if a cutscene is NOT active AND dialogue is NOT visible.
	var can_move = !global.cutscene_active && !global.dialogue_visible;

	if (can_move) {
		// ## Player Input and Movement ##

		// 1. GET PLAYER INPUT
		// Get keyboard inputs for each direction
		var key_up = keyboard_check(ord("W"));
		var key_down = keyboard_check(ord("S"));
		var key_left = keyboard_check(ord("A"));
		var key_right = keyboard_check(ord("D"));

		// Calculate the horizontal and vertical movement amount
		var move_x = key_right - key_left; // -1 for left, 1 for right, 0 for none
		var move_y = key_down - key_up;   // -1 for up, 1 for down, 0 for none

		// 2. MOVE THE PLAYER
		// Update the player's x and y coordinates
		x += move_x * moveSpeed;
		y += move_y * moveSpeed;

		// 3. UPDATE THE SPRITE
		// Check if the player is moving
		if (move_x != 0 || move_y != 0) {
		    // Player is moving, so update to a walking sprite.
		    // The code prioritizes vertical sprites if moving diagonally.
		    if (move_y < 0) {
		        sprite_index = spr_MCBW;
		    } else if (move_y > 0) {
		        sprite_index = spr_MCFW;
		    } else if (move_x < 0) {
		        sprite_index = spr_MCLW;
		    } else if (move_x > 0) {
		        sprite_index = spr_MCRW;
		    }
		} else {
		    // Player is NOT moving, so switch to the single idle sprite
		    sprite_index = spr_MC_Idle;
		}
	}
}