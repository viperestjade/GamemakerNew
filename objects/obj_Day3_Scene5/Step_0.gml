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
    case 0: // Formerly case 1
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The room smells faintly of tea and carpet cleaner. A small couch. A desk with no clutter. A salt lamp flickers in the corner. The school counselor looks up and smiles.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1: // Formerly case 2
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "Hey there. I’m glad you came in. You can sit wherever you like.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            // End of this standalone scene, return control to player
            global.dialogue_visible = false;
            global.cutscene_active = false;
            instance_destroy();
        }
        break;
}