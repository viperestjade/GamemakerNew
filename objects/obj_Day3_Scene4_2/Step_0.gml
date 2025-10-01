// ===============================================================
// SCRIPT 1: First Part as a Standalone Scene
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
    case 0: // Formerly case 3
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You find yourself walking the hallway without really deciding to. Until you’re standing in front of a door with soft light spilling underneath and a nameplate that suddenly feels a little less intimidating. You knock once, then open it.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            // --- MODIFIED ENDING: Go to the next room ---
            // !! REPLACE 'your_target_room' WITH THE ACTUAL ROOM NAME !!
            room_goto(room_Day3_Scene5); 
            instance_destroy();
        }
        break;
}