// --- Cutscene ID Check (decides which cutscene to run)
switch (global.cutscene_id) {

    case 0: // Cutscene 1: Argument between parents
        if (fade_alpha > 0) fade_alpha -= 0.02;

        if (dialogue_visible) {
            typewriter_counter += 1;
            if (typewriter_counter >= typewriter_speed) {
                typewriter_counter = 0;
                if (typewriter_index < string_length(current_dialogue)) {
                    typewriter_index += 1;
                    displayed_text = string_copy(current_dialogue, 1, typewriter_index);
                }
            }
        } else {
            typewriter_index = 0;
            displayed_text = "";
        }

        switch (cutscene_step) {
            case 0:
                if (dialogue_stage == 0 && !dialogue_visible) {
                    dialogue_speaker = "Mother (muffled)";
                    current_dialogue = "So you’re just going to leave her here with us pretending it’s normal?!";
                    dialogue_visible = true;
                } 
                else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
				    dialogue_stage = 1;
				    dialogue_speaker = "Father (muffled)";
				    current_dialogue = "It’s always on me, isn’t it? What about what I want?";
				    typewriter_index = 0;
				    displayed_text = "";
				    typewriter_counter = 0;
				    dialogue_visible = true;
				}

                else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 0;
                    dialogue_visible = false;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "I wish I was somewhere else.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 2;
                }
                break;

            case 2:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "Put on headphones and shut it out",
                        "Text a friend (no reply)",
                        "Just sit and listen quietly"
                    ];
                    choice_selected = 0;
                    choice_active = true;
                }
                else if (choice_active) {
                    if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
                    if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
                    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
                        choice_made = true;
                        choice_active = false;
                        dialogue_speaker = "Inner Thought";
                        current_dialogue = choice_options[choice_selected];
                        dialogue_visible = true;
                        cutscene_step = 3; // now show result
                    }
                }
                break;

            case 3:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;

            case 4:
                if (!dialogue_visible) {
                    dialogue_speaker = "";
                    current_dialogue = "You leave for school. No one says goodbye.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    global.cutscene_id = 1;
                    global.cutscene_active = true;
                    room_goto(school_cutscene1);
                }
                break;
        }
        break;

    case 1: // Cutscene 2: MC walks to school
        if (fade_alpha > 0) fade_alpha -= 0.02;

        if (dialogue_visible) {
            typewriter_counter += 1;
            if (typewriter_counter >= typewriter_speed) {
                typewriter_counter = 0;
                if (typewriter_index < string_length(current_dialogue)) {
                    typewriter_index += 1;
                    displayed_text = string_copy(current_dialogue, 1, typewriter_index);
                }
            }
        } else {
            typewriter_index = 0;
            displayed_text = "";
        }

        switch (cutscene_step) {
            case 0:
                if (!dialogue_visible) {
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "They don’t know what it's like to feel invisible... or too visible at home.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "Keep head down and walk",
                        "Glance at them and smile",
                        "Bump into someone and apologize quickly"
                    ];
                    choice_selected = 0;
                    choice_active = true;
                }
                else if (choice_active) {
                    if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
                    if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
                    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
                        choice_made = true;
                        choice_active = false;
                        dialogue_speaker = "Inner Thought";
                        current_dialogue = choice_options[choice_selected];
                        dialogue_visible = true;
                        cutscene_step = 2;
                    }
                }
                break;

            case 2:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 3;
                }
                break;

            case 3:
                if (!dialogue_visible) {
                    dialogue_speaker = "";
                    current_dialogue = "The day continues as usual.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    global.cutscene_active = false;
                    room_goto(house);
                }
                break;
        }
        break;
}
