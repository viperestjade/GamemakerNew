switch (global.cutscene_id) {
    case 3: // Scene: Muted Mornings
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
                    dialogue_speaker = "Narration";
                    current_dialogue = "The sun barely slips through the curtains. The room feels colder today, like the quiet before a storm, only there’s no yelling this time.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "Maybe today won’t be like the others.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 2;
                }
                break;

            case 2:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You slip out of bed, tugging on your clothes mechanically, as if you’ve done this too many times to care. Your bag feels heavier than usual, and your thoughts, they’re just as scattered.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 3;
                }
                break;

            case 3:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "The sound of clattering dishes drifts to your room. It’s only your mom. She must be making breakfast, but there’s no noise beyond that. No shuffling, no small talk. Just the faint, rhythmic sound of someone trying not to be noticed.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    room_goto(house_day2_scene1_1);
					dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;

            case 4:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "I made eggs. You’ve got time, if you want to eat.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 5;
                }
                break;

            case 5:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "Thanks, I’ll eat.",
                        "I’m not hungry. Maybe later.",
                        "I’m good, but I appreciate it."
                    ];
                    choice_selected = 0;
                    choice_active = true;
                } 
                else if (choice_active) {
                    if (keyboard_check_pressed(vk_down)) {
                        choice_selected = (choice_selected + 1) % array_length(choice_options);
                    }
                    if (keyboard_check_pressed(vk_up)) {
                        choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
                    }
                    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
                        choice_made = true;
                        choice_active = false;

                        dialogue_speaker = "You";
                        current_dialogue = choice_options[choice_selected];
                        dialogue_visible = true;

                        if (choice_selected == 0) player_mood += 1;
                        else if (choice_selected == 1) player_mood -= 1;
                        else if (choice_selected == 2) player_mood += 0;

                        global.player_mood = player_mood;

                        cutscene_step = 5.5;
                    }
                }
                break;

            case 5.5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 6;
                }
                break;

            case 6:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You sit down at the small kitchen table. Your mom is still standing at the stove, her movements slow and mechanical, like she's trying to avoid saying anything else.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 6.5;
                }
                break;

            case 6.5:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "The eggs sit in front of you, warm but unappealing. The house is quieter than usual, no loud arguments or tension filling the space, just the soft hum of the kitchen and the muted clatter of your mom’s movements.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 7;
                }
                break;

            case 7:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "I’ll try to be home earlier today. I know things haven’t been easy for either of us.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 7.5;
                }
                break;

            case 7.5:
                if (!dialogue_visible) {
                    dialogue_speaker = "You";
                    current_dialogue = "Okay";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 8;
                }
                break;

            case 8:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "No words need to be said. Your mom doesn’t press you, and you don’t press her either. It’s just quiet, the kind of quiet that feels like waiting for something, but you’re not sure what.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 8.5;
                }
                break;

            case 8.5:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "After a few moments, you stand up, gathering your bag, and as you head for the door, your mom watches you with those tired eyes of hers. She doesn’t say anything else, just nods.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 9;
                }
                break;

            case 9:
                if (!dialogue_visible) {
                    global.cutscene_id = 4;
                    global.cutscene_active = true;
                    room_goto(school_day2_scene1); // Next scene
                }
                break;
        }
        break;
}
