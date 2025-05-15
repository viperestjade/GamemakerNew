switch (global.cutscene_id) {
    case 5: // Scene: Homeward Bound
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
                    current_dialogue = "You arrive home later than usual, the sky already dimming as the weight of the day presses on. The house feels quieter than before, but in a different way. The tension from this morning has shifted, and you can’t quite tell whether it’s better or worse.";
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
                    current_dialogue = "There’s the quiet clink of cutlery. The faint sound of the news hums from the living room. A gentle rustle of paper. You hear your parents, but they’re not talking to each other.";
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
                    current_dialogue = "You move slowly toward the kitchen.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    room_goto(house_day2_scene2_1);
					dialogue_visible = false;
                    cutscene_step = 3;
                }
                break;

            case 3:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "There’s stew on the stove. You can heat some up if you’re hungry.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;
				
			case 4:
                if (!dialogue_visible) {
                    dialogue_speaker = "Father";
                    current_dialogue = "Long day?";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 5;
                }
                break;
				
			case 5:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "It’s the first thing he’s said to you in a while. It doesn’t demand a reply, just leaves space for one if you want it.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 6;
                }
                break;
				
			case 6:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You give a small shrug. Not because you’re trying to shut them out, but because you don’t know what to say yet.";
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
                    current_dialogue = "There’s still warm bread. I can slice some, if you want.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 8;
                }
                break;
				
			case 8:
                if (!dialogue_visible) {
                    dialogue_speaker = "Father";
                    current_dialogue = "I think she can manage, hon. But if you want it, it’s there.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 9;
                }
                break;
				
			case 9:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "They’re trying, in their own quiet ways. No pressure. No questions. Just… space. Space that feels a little easier to breathe in tonight.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 10;
                }
                break;
				
			case 10:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "We’ve been… thinking about things. About how things have felt lately.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 11;
                }
                break;
				
			case 11:
                if (!dialogue_visible) {
                    dialogue_speaker = "Father";
                    current_dialogue = "We know we haven’t made it easy here. For you. Or for each other.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 12;
                }
                break;
				
			case 12:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "You don’t have to say anything right now. But… if there’s anything on your mind, anything at all, we’re listening.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 13;
                }
                break;
				
			case 13:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "It’s quiet again. But not heavy. Just uncertain, like everyone’s waiting to see if someone will dare to be honest first.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 14;
                }
                break;

            case 14:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "I don’t know what to say yet… but I hear you.",
                        "I’m tired. That’s all.",
                        "Can we… maybe not do this right now?"
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
                        else if (choice_selected == 2) player_mood -= 1;

                        global.player_mood = player_mood;

                        cutscene_step = 14.5;
                    }
                }
                break;

            case 14.5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 15;
                }
                break;

            case 15:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "They both nod, almost at the same time.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 16;
                }
                break;
				
			case 16:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "Okay. Whenever you’re ready.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 17;
                }
                break;
				
			case 17:
                if (!dialogue_visible) {
                    dialogue_speaker = "Father";
                    current_dialogue = "We just want you to know you’re not alone. That’s all.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					dialogue_visible = false;
                    cutscene_step = 18;
                }
                break;

            case 18:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You don’t say anything else. The air feels different than it did this morning, not fixed, but softer. Like the ground isn't shaking quite as hard. You head back to your room.";
                    dialogue_visible = true;
                } 
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {     
					dialogue_visible = false;
                    cutscene_step = 19;
                }
                break;
                      
            case 19:
                if (!dialogue_visible) {
                    global.cutscene_id = 6;
                    global.cutscene_active = true;
                    room_goto(house_day3_scene1); // Next scene
                }
                break;
        }
        break;
}
