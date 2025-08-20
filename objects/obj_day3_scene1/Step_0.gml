switch (global.cutscene_id) {
    case 6: // Scene: Morning Light
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
                if (fade_alpha > 0) fade_alpha -= 0.02;
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "The sun filters in through the curtain slats. A little too bright, a little too early. But it doesn’t feel heavy today. Just quiet.";
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
                    current_dialogue = "You pull yourself out of bed, slow but steady. Get dressed and sling your bag over your shoulder.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    room_goto(house_day3_scene1_1);
                    dialogue_visible = false;
                    cutscene_step = 2;
                }
                break;
        
            case 2:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "As you step into the kitchen, both your parents look up. Your mom offers a faint smile. Your dad nods.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 3;
                }
                break;
        
            case 3:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "Have a good day, okay?";
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
                    current_dialogue = "Call us if anything comes up.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 5;
                }
                break;
        
            case 5:
                if (!dialogue_visible) {
                    dialogue_speaker = "You";
                    current_dialogue = "I will.";
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
                    current_dialogue = "No speeches. No apologies. But somehow, it means more this way.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 7;
                }
                break;
        
            case 7:
                if (!dialogue_visible) {
                    global.cutscene_id = 7;
                    global.cutscene_active = true;
                    room_goto(school_day3_scene1); // Next scene
                }
                break;
        	}
        	break;
        }
