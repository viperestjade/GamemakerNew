// ===============================================================
// SCRIPT: Controls the scene and returns control to the player
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

// --- Scene Progression ---
switch (cutscene_step) {
    case 0:
        if (fade_alpha > 0) fade_alpha -= 0.02;
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The sun filters in through the curtain slats. A little too bright, a little too early. But it doesn’t feel heavy today. Just quiet.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You pull yourself out of bed, slow but steady. Get dressed and sling your bag over your shoulder.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            // This is the end of the cutscene. Hide the dialogue box.
            global.dialogue_visible = false;
            
            // Allow the player to move again.
            // (This assumes your player object checks this global variable)
            global.cutscene_active = false; 
            
            // This controller object's job is done.
            instance_destroy(); 
        }
        break;
}