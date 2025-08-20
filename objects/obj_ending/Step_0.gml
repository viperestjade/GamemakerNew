// Cutscene flow
switch (global.cutscene_id) {
    case 100: // Good Ending: The Door Opens
        // Typewriter and fade update
        if (fade_alpha > 0 && !cutscene_ending) {
            fade_alpha -= 0.02;
        }

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

        // Handle cutscene ending transition
        if (cutscene_ending) {
            fade_alpha += 0.02;
            if (fade_alpha >= 1) {
                room_goto(menu); // Go back to menu room
            }
        }

        switch (cutscene_step) {
            case 0:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You meet their eyes. And for the first time in a while, you don’t look away.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "You";
                    current_dialogue = "I’ve been overwhelmed. School, everything. I went to see the counselor today. It helped.";
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
                    current_dialogue = "Your mom presses her lips together, and your dad lowers his gaze for a second, both visibly moved.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 3;
                }
                break;

            case 3:
                if (!dialogue_visible) {
                    dialogue_speaker = "Dad";
                    current_dialogue = "We’re proud of you. That’s not easy to do.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;

            case 4:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mom";
                    current_dialogue = "Thank you for telling us. Really. You don’t have to go through this alone.";
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
                    current_dialogue = "The silence that follows isn’t awkward this time. It’s full. Full of things unsaid, but also of willingness. Of beginnings.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 6;
                }
                break;

            case 6:
                if (!dialogue_visible && !cutscene_ending) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "It’s not fixed. But it’s open now. The space between you feels walkable. The weight doesn’t vanish, but it lifts, just enough to breathe.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_ending = true;
                }
                break;
        }
        break;

    case 200: // Bad Ending: Walls Remain
        // Typewriter and fade update
        if (fade_alpha > 0 && !cutscene_ending) {
            fade_alpha -= 0.02;
        }

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

        // Handle cutscene ending transition
        if (cutscene_ending) {
            fade_alpha += 0.02;
            if (fade_alpha >= 1) {
                room_goto(menu); // Go back to menu room
            }
        }

        switch (cutscene_step) {
            case 0:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You pause at their words… but something in your chest closes off again. You nod instead of speaking.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 1;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "You";
                    current_dialogue = "I’m fine. Just tired.";
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
                    current_dialogue = "Your dad doesn’t push. Your mom offers a thin smile. The silence returns, heavier this time.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 3;
                }
                break;

            case 3:
                if (!dialogue_visible) {
                    dialogue_speaker = "Mom";
                    current_dialogue = "Alright. If you ever want to talk…";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 4;
                }
                break;

            case 4:
                if (!dialogue_visible) {
                    dialogue_speaker = "Dad";
                    current_dialogue = "We’re here. You know that, right?";
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
                    current_dialogue = "You give a small nod. Not quite yes, not quite no. Then excuse yourself and head to your room.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 6;
                }
                break;

            case 6:
                if (!dialogue_visible && !cutscene_ending) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "The walls stay up tonight. Maybe they always were. And maybe you're not ready to tear them down. Not yet.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_ending = true;
                }
                break;
        }
        break;
}
