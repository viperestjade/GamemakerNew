switch (global.cutscene_id) {

    case 2: // Scene: Echoes in the Kitchen
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
				if (fade_alpha > 0) fade_alpha -= 0.02;
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "You’re back early.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_speaker = "You";
                    current_dialogue = "School ended. Same as always.";
                    dialogue_visible = true;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 2;
                }
                break;

            case 2:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "I made mushroom soup. You still like that, right?";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_speaker = "You";
                    current_dialogue = "Yeah. Thanks.";
                    dialogue_visible = true;
                    cutscene_step = 3;
                }
                break;

            case 3:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "Your dad says he’s doing it for us. Maybe that’s true. But it’s not enough, is it?";
                    dialogue_visible = true;
                    cutscene_step = 3.5;
                }
                break;

            case 3.5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;

            case 4:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "I don’t even know what’s enough anymore.",
                        "Say nothing",
                        "You’re doing more than either of us knows how to say."
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

                        dialogue_speaker = "You";
                        current_dialogue = choice_options[choice_selected];
                        dialogue_visible = true;

                        if (choice_selected == 0) player_mood -= 1;
                        else if (choice_selected == 1) player_mood -= 2;
                        else if (choice_selected == 2) player_mood += 2;
                        global.player_mood = player_mood;

                        cutscene_step = 5;
                    }
                }
                break;

            case 5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 6;
                }
                break;

            case 6:
                if (!dialogue_visible) {
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "The quiet isn’t peaceful, it’s just quiet. No yelling, no harsh words. But the space still feels heavy.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    global.cutscene_id = 3;
                    global.cutscene_active = true;
                    dialogue_visible = false;
                    room_goto(house_day2_scene1); // Replace with your next actual room name
                }
                break;
        }
        break;
}
