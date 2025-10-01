// ===============================================================
// SCRIPT 2: Second Part as a Standalone Scene
// ===============================================================

// --- Fade-in and Typewriter Logic ---
if (fade_alpha > 0) fade_alpha -= 0.02;

if (global.dialogue_visible) {
    var total_dialogue_length = string_length(current_dialogue);
    var dialogue_is_fully_typed = (typewriter_index >= total_dialogue_length);

    if (!dialogue_is_fully_typed) { // Still typing
        typewriter_counter += 1;
        if (typewriter_counter >= typewriter_speed) {
            typewriter_counter = 0;
            typewriter_index = min(typewriter_index + 1, total_dialogue_length);
            displayed_text = string_copy(current_dialogue, 1, typewriter_index);
        }
    } else { // Typing finished
        displayed_text = current_dialogue;
    }
} else { // Dialogue not visible, reset
    typewriter_index = 0;
    displayed_text = "";
    typewriter_counter = 0;
}

// --- Handle Dialogue Skip with Space Key ---
if (global.dialogue_visible && keyboard_check_pressed(vk_space) && typewriter_index < string_length(current_dialogue)) {
    typewriter_index = string_length(current_dialogue);
    displayed_text = current_dialogue;
    exit;
}

// --- Scene Progression (With Automatic Movement) ---
switch (cutscene_step) {
    case 0: // Formerly case 2
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "As you step into the kitchen, both your parents look up. Your mom offers a faint smile. Your dad nods.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            
            // --- START MC MOVEMENT ---
            with (obj_MC) {
                // !! SET YOUR TARGET COORDINATES HERE !!
                target_x = 320;
                target_y = 336;
                is_moving_automatically = true;
            }
            
            cutscene_step = 0.5;
        }
        break;

    // --- NEW: WAITING STEP FOR MC MOVEMENT ---
    case 0.5:
        if (!instance_exists(obj_MC) || !obj_MC.is_moving_automatically) {
            cutscene_step = 1;
        }
        break;

    case 1: // Formerly case 3
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "Have a good day, okay?";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 2;
        }
        break;

    case 2: // Formerly case 4
        if (!global.dialogue_visible) {
            dialogue_speaker = "Father";
            current_dialogue = "Call us if anything comes up.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;

    case 3: // Formerly case 5
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "I will.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4;
        }
        break;

    case 4: // Formerly case 6
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "No speeches. No apologies. But somehow, it means more this way.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 5;
        }
        break;

    case 5: // Formerly case 7
        if (!global.dialogue_visible) {
            // --- MODIFIED ENDING: Return control to player ---
            global.cutscene_active = false; // Allow the player to move again
            instance_destroy(); // End the cutscene
        }
        break;
}