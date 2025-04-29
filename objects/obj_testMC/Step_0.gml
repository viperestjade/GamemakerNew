// Step Event

if (!global.cutscene_active) {
    // Reset movement
    var move_x = 0;
    var move_y = 0;

    // Key checking
    if (keyboard_check(ord("W"))) {
        move_y = -1;
        sprite_index = spr_mcBW;
        image_speed = 2;
    }
    else if (keyboard_check(ord("S"))) {
        move_y = 1;
        sprite_index = spr_mcFW;
        image_speed = 2;
    }
    else if (keyboard_check(ord("A"))) {
        move_x = -1;
        sprite_index = spr_mcLW;
        image_speed = 2;
    }
    else if (keyboard_check(ord("D"))) {
        move_x = 1;
        sprite_index = spr_mcRW;
        image_speed = 2;
    }
    else {
        // No movement keys pressed
        sprite_index = spr_mcIdle;
        image_speed = 0;
    }

    // Apply movement
    x += move_x * move_speed;
	y += move_y * move_speed;
}
else {
    // Cutscene is active — force idle sprite
    sprite_index = spr_mcIdle;
    image_speed = 0;
}