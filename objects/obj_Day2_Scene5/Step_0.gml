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

// --- Dialogue Skip Logic ---
if (global.dialogue_visible && keyboard_check_pressed(vk_space) && typewriter_index < string_length(current_dialogue)) {
    typewriter_index = string_length(current_dialogue);
    displayed_text = current_dialogue;
    exit; // Prevents advancing dialogue in the same frame
}

// --- Scene Progression ---
switch (cutscene_step) {
    case 0:
        if (fade_alpha > 0) fade_alpha -= 0.02;
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You arrive home later than usual, the sky already dimming as the weight of the day presses on. The house feels quieter than before, but in a different way. The tension from this morning has shifted, and you can’t quite tell whether it’s better or worse.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "There’s the quiet clink of cutlery. The faint sound of the news hums from the living room. A gentle rustle of paper. You hear your parents, but they’re not talking to each other.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            // --- MODIFIED: End the cutscene here ---
            global.dialogue_visible = false;
            
            // Give control back to the player.
            // (This assumes your player object checks this variable to allow movement)
            global.cutscene_active = false; 
            
            // This controller's job is done.
            instance_destroy(); 
        }
        break;
        
    // Case 2 has been completely removed.
}