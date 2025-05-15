switch (global.cutscene_id) {
    case 4: // Scene: Muted Mornings
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
                    current_dialogue = "The bell rings, but today, it doesn’t feel like the usual signal to start a class. You slip into your seat, trying to avoid the gaze of anyone nearby. The room hums with chatter, but your mind feels far away, distant from the buzz of everyday school life.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You can’t focus on anything. The teacher’s voice seems like it’s coming from underwater, and the words just blur into a stream of noise.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 2;
                }
                break;

            case 2:
                if (!dialogue_visible) {
                    dialogue_speaker = "Teacher";
                    current_dialogue = "Hey, you doing alright? You’ve been kind of quiet today.";
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
                    current_dialogue = "Your teacher's concern catches you off guard. You shrug, not feeling like explaining anything right now. You hope they'll drop it, but the teacher lingers for a moment, scanning you carefully.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;

            case 4:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "Just got some stuff on my mind.",
                        "I’m fine. Don’t worry about me.",
                        "I’m fine, just tired."
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

                        cutscene_step = 4.5;
                    }
                }
                break;

            case 4.5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 5;
                }
                break;

            case 5:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You sink further into your seat, feeling like you’re on the edge of being seen, like you’re being watched but don’t want to be found. Your mind starts to wander. The thought of talking to someone, anyone, feels like a mountain you’re too tired to climb.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    room_goto(school_day2_scene1_1);
					dialogue_visible = false;
                    cutscene_step = 6;
                }
                break;

            case 6:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "The lunch bell rings, and you head outside, but something’s different. You catch Casey’s eyes as she walks by. She slows down, hesitating for a second before making her way over to you.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {               
					dialogue_visible = false;
                    cutscene_step = 7;
                }
                break;

            case 7:
                if (!dialogue_visible) {
                    dialogue_speaker = "Casey";
                    current_dialogue = "Hey, you okay? You’re not usually this... quiet.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
					choice_made = false;
                    cutscene_step = 8;
                }
                break;

            case 8:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "Honestly, I’m not okay. I don’t even know where to start.",
                        "Why are you asking? It’s not like it’s any of your business.",
                        "Yeah, just a lot on my mind. Nothing big."
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
                        else if (choice_selected == 1) player_mood -= 2;
                        else if (choice_selected == 2) player_mood += 0;

                        global.player_mood = player_mood;

                        cutscene_step = 8.5;
                    }
                }
                break;
				
			case 8.5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 9;
                }
                break;

            case 9:
                if (!dialogue_visible) {
                    dialogue_speaker = "Casey";
                    current_dialogue = "Well ok but if you ever want to talk, I’m here. You don’t have to go through this alone, you know?";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 10;
                }
                break;          

            case 10:
                if (!dialogue_visible) {
                    global.cutscene_id = 5;
                    global.cutscene_active = true;
                    room_goto(house_day2_scene2); // Next scene
                }
                break;
        }
        break;
}
