// --- Automatic Cutscene Movement ---
// First, check if a cutscene has ordered this NPC to move.
if (is_moving_automatically) {
    // Calculate direction and distance to the target
    var _dir = point_direction(x, y, target_x, target_y);
    var _dist = point_distance(x, y, target_x, target_y);

    // Check if we still need to move
    if (_dist > cutscene_move_speed) {
        // 1. Move the character
        x += lengthdir_x(cutscene_move_speed, _dir);
        y += lengthdir_y(cutscene_move_speed, _dir);

        // 2. Update the animation based on direction
        // NOTE: Replace these with your actual teacher sprite names!
        if ((_dir >= 45) && (_dir < 135)) {
            sprite_index = spr_CaseyBW; // Walking Up
        }
        else if ((_dir >= 135) && (_dir < 225)) {
            sprite_index = spr_CaseyLW; // Walking Left
        }
        else if ((_dir >= 225) && (_dir < 315)) {
            sprite_index = spr_CaseyFW; // Walking Down
        }
        else {
            sprite_index = spr_CaseyRW; // Walking Right
        }
    }
    // If we have arrived
    else {
        // 3. Stop and finalize the movement
        x = target_x; // Snap to the final position
        y = target_y;
        is_moving_automatically = false; // Signal that movement is finished
        sprite_index = spr_Casey_Idle; // Revert to the idle sprite
    }
    
    // Stop any other NPC logic from running while moving automatically
    exit;
}

// --- Your Regular NPC Logic (like standing still) Goes Below This Line ---
// For example, you might ensure the idle sprite is set if not moving.
if (!is_moving_automatically) {
    sprite_index = spr_Casey_Idle;
}