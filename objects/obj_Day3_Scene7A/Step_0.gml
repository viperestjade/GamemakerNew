// ===============================================================
// Good Ending: The Door Opens
// ===============================================================

// --- Fade-in/out and Typewriter Logic ---
if (fade_alpha > 0 && !cutscene_ending) {
    fade_alpha -= 0.02;
}

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

// --- Handle cutscene ending transition ---
if (cutscene_ending) {
    fade_alpha += 0.02;
    if (fade_alpha >= 1) {
        room_goto(room_Home_Page); // Go back to menu room
    }
}

// --- Scene Progression ---
switch (cutscene_step) {
    case 0:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You meet their eyes. And for the first time in a while, you don’t look away.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1:
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "I’ve been overwhelmed. School, everything. I went to see the counselor today. It helped.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 2;
        }
        break;

    case 2:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "Your mom presses her lips together, and your dad lowers his gaze for a second, both visibly moved.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;

    case 3:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Dad";
            current_dialogue = "We’re proud of you. That’s not easy to do.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4;
        }
        break;

    case 4:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mom";
            current_dialogue = "Thank you for telling us. Really. You don’t have to go through this alone.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 5;
        }
        break;

    case 5:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The silence that follows isn’t awkward this time. It’s full. Full of things unsaid, but also of willingness. Of beginnings.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 6;
        }
        break;

    case 6:
        if (!global.dialogue_visible && !cutscene_ending) {
            dialogue_speaker = "Narration";
            current_dialogue = "It’s not fixed. But it’s open now. The space between you feels walkable. The weight doesn’t vanish, but it lifts, just enough to breathe.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_ending = true;
        }
        break;
}