switch (global.cutscene_id) {
	case 8: // Scene: Two Door's Down
        if (fade_alpha > 0) fade_alpha -= 0.02;

        // --- Typewriter logic ---
        if (dialogue_visible) {
            var total_dialogue_length = string_length(current_dialogue);
            var dialogue_is_fully_typed = (typewriter_index >= total_dialogue_length);

            if (!dialogue_is_fully_typed) { // Still typing
                typewriter_counter += 1;
                if (typewriter_counter >= typewriter_speed) {
                    typewriter_counter = 0;
                    typewriter_index = min(typewriter_index + 1, total_dialogue_length);
                    displayed_text = string_copy(current_dialogue, 1, typewriter_index);

                    // 🔊 Added: Typing sound for visible characters
                    var char = string_char_at(current_dialogue, typewriter_index);
                    if (char != " ") {
                        audio_play_sound(snd_type, 0, false);
                        audio_sound_pitch(snd_type, random_range(0.9, 0.95));
                    }
                }
            } else { // Typing finished, ensure displayed_text is fully complete
                displayed_text = current_dialogue;
            }
        } else { // Dialogue not visible, reset typewriter state
            typewriter_index = 0;
            displayed_text = "";
            typewriter_counter = 0; // Ensure counter is reset when dialogue box is hidden
        }
        
        // --- NEW LOGIC: Handle Dialogue Skip with Space Key ---
        // If space is pressed AND dialogue is visible AND dialogue is still typing
        if (dialogue_visible && keyboard_check_pressed(vk_space) && typewriter_index < string_length(current_dialogue)) {
            // Skip to the end of the current dialogue immediately
            typewriter_index = string_length(current_dialogue);
            displayed_text = current_dialogue;
            // Use 'exit;' to prevent the dialogue from advancing to the next stage
            // in the same frame that the player skipped the typing.
            // A subsequent space press will then advance the dialogue.
            exit;
        }
        // --- END NEW LOGIC ---
        
        switch (cutscene_step) {
            case 0:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "Later in the day, a teacher quietly pulls you aside after class.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "Teacher";
                    current_dialogue = "Hey. The counselor’s available today. You’re not in trouble or anything. They’re just… there if you feel like talking. No pressure.";
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
                    current_dialogue = "You nod slowly. Something about today, the way Casey listened, the way your parents didn’t push, makes the offer feel... less heavy.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    room_goto(school_day3_scene2_1);
                    dialogue_visible = false;
                    cutscene_step = 3;
                }
                break;

            case 3:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You find yourself walking the hallway without really deciding to. Until you’re standing in front of a door with soft light spilling underneath and a nameplate that suddenly feels a little less intimidating. You knock once, then open it.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    room_goto(school_day3_scene2_2);
                    dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;

            case 4:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "The room smells faintly of tea and carpet cleaner. A small couch. A desk with no clutter. A salt lamp flickers in the corner. The school counselor looks up and smiles.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 5;
                }
                break;

            case 5:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "Hey there. I’m glad you came in. You can sit wherever you like.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 6;
                }
                break;
				
            case 6:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "Don’t worry about saying everything perfectly. We just talk here. Or not talk. Whatever you need.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 7;
                }
                break;
				
            case 7:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You nod, your hands resting between your knees.";
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
                        "I’ve just been really tired. Not just sleep-tired.",
                        "I don’t really know why I’m here.",
                        "I’m fine. I just… wanted to see."
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

                        if (choice_selected == 0) player_mood += 2;
                        else if (choice_selected == 1) player_mood += 1;
                        else if (choice_selected == 2) player_mood -= 1;

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
                    dialogue_speaker = "Counselor";
                    current_dialogue = "That’s okay. However we start, it’s still a beginning.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 10;
                }
                break;

            case 10:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "Do you want to tell me a bit about what’s been heavy lately? School? Home? Yourself?";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 11;
                }
                break;
				
            case 11:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You breathe in. Your fingers tap your knee once, twice.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    choice_made = false;
                    cutscene_step = 12;
                }
                break;
				
            case 12:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "It’s just… I feel like I’m slipping behind everyone. Like I’m the only one stuck.",
                        "There’s this girl, Casey, she noticed I wasn’t okay. And it kind of scared me.",
                        "It’s tense at home. Like, we’re all avoiding something but no one wants to say it."
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
                        else if (choice_selected == 1) player_mood += 1;
                        else if (choice_selected == 2) player_mood += 2;

                        global.player_mood = player_mood;

                        cutscene_step = 12.5;
                    }
                }
                break;

            case 12.5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 13;
                }
                break;
			
            case 13:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "Sounds like you’re carrying a lot. And it’s starting to weigh more now that you’ve noticed it, right?";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 14;
                }
                break;
				
            case 14:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You nod. More certain now than when you walked in. They don’t rush you. Don’t try to patch you up like a broken pipe. They just… listen.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 15;
                }
                break;
				
            case 15:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "You’ve been carrying this mostly on your own, haven’t you? (You nod slightly.)";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 16;
                }
                break;
				
            case 16:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "I’m really glad you opened up here. But I wonder… have you ever tried talking to your parents about any of this?";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 17;
                }
                break;	
				
            case 17:
                if (!dialogue_visible) {
                    dialogue_speaker = "You";
                    current_dialogue = "Not really. It’s… complicated. They’re always so wrapped up in their own mess, I don’t even know where I’d start.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 18;
                }
                break;
				
            case 18:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "I get that. And I’m not saying it’ll be easy, or perfect. But you matter to them. Sometimes they just need to hear it from you. Not just the silence between you all.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 19;
                }
                break;
				
            case 19:
                if (!dialogue_visible) {
                    dialogue_speaker = "You";
                    current_dialogue = "What if it just makes things worse?";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 20;
                }
                break;
				
            case 20:
                if (!dialogue_visible) {
                    dialogue_speaker = "Counselor";
                    current_dialogue = "It might feel messy at first. But honesty has a way of planting seeds. Even if they take time to grow. You don’t have to do it alone, either. I can help you figure out how to start, if you want.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 21;
                }
                break;
				
            case 21:
                if (!dialogue_visible) {
                    dialogue_speaker = "You";
                    current_dialogue = "…Okay. Maybe. I’ll try tonight.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 22;
                }
                break;
            
            case 22:
                if (!dialogue_visible) {
                    global.cutscene_id = 9;
                    global.cutscene_active = true;
                    room_goto(house_day3_scene2); // move to next room/scene
                }
                break;
        }
        break;
}