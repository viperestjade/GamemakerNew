// STEP
// --- Fade from black
if (fade_alpha > 0) {
    fade_alpha -= 0.02;
}

// --- Update typewriter
if (dialogue_visible) {
    typewriter_counter += 1;
    if (typewriter_counter >= typewriter_speed) {
        typewriter_counter = 0;

        if (typewriter_index < string_length(current_dialogue)) {
            typewriter_index += 1;
            displayed_text = string_copy(current_dialogue, 1, typewriter_index);
        }
    }
}
else {
    typewriter_index = 0;
    displayed_text = "";
}

// --- Choice input
if (choice_active) {
    if (keyboard_check_pressed(vk_up)) {
        choice_selected = (choice_selected - 1 + array_length(choice_options)) mod array_length(choice_options);
    }
    if (keyboard_check_pressed(vk_down)) {
        choice_selected = (choice_selected + 1) mod array_length(choice_options);
    }
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
        choice_result = choice_selected;

        if (choice_result == 0) {
            player_mood -= 1;
        }
        else if (choice_result == 2) {
            player_mood -= 2;
        }
        // choice 1 does nothing

        choice_made = true;
        choice_active = false;
    }
}

// --- Cutscene Steps
switch (cutscene_step) {

    case 0: // Argument between parents
        if (dialogue_stage == 0 && !dialogue_visible) {
            dialogue_speaker = "Mother (muffled)";
            current_dialogue = "So you’re just going to leave her here with us pretending it’s normal?!";
            typewriter_index = 0;
            displayed_text = "";
            typewriter_counter = 0;
            dialogue_visible = true;
        }
        else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            dialogue_stage = 1;
            dialogue_speaker = "Father (muffled)";
            current_dialogue = "It’s always on me, isn’t it? What about what I want?";
            typewriter_index = 0;
            displayed_text = "";
            typewriter_counter = 0;
        }
        else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            cutscene_step = 1;
            dialogue_stage = 0;
            dialogue_visible = false;
        }
        break;

    case 1: // Inner Thought
        if (dialogue_stage == 0 && !dialogue_visible) {
            dialogue_speaker = "Inner Thought";
            current_dialogue = "I wish I was somewhere else.";
            typewriter_index = 0;
            displayed_text = "";
            typewriter_counter = 0;
            dialogue_visible = true;
        }
        else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            cutscene_step = 2;
            dialogue_stage = 0;
            dialogue_visible = false;
        }
        break;

    case 2: // Choice
        if (!choice_made && !choice_active) {
            choice_options = [
                "Put on headphones and shut it out",
                "Text a friend (no reply)",
                "Just sit and listen quietly"
            ];
            choice_selected = 0;
            choice_active = true;
            dialogue_visible = false;
        }
        else if (choice_made) {
            cutscene_step = 3;
            dialogue_stage = 0;
            choice_made = false;
        }
        break;

    case 3: // After choice, leaving home
        if (dialogue_stage == 0 && !dialogue_visible) {
            dialogue_speaker = "";
            current_dialogue = "You leave for school. No one says goodbye.";
            typewriter_index = 0;
            displayed_text = "";
            typewriter_counter = 0;
            dialogue_visible = true;
        }
        else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.cutscene_active = false;
            room_goto(school_cutscene1); // <--- your main gameplay room
        }
        break;
}
