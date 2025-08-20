// --- Cutscene ID Check (decides which cutscene to run)
switch (global.cutscene_id) {

    case 0: // Cutscene 1: Same Morning, Different Storm
        if (fade_alpha > 0) fade_alpha -= 0.02;

        // --- Typewriter logic ---
        if (dialogue_visible) {
            var total_dialogue_length = string_length(current_dialogue);
            var dialogue_is_fully_typed = (typewriter_index >= total_dialogue_length);

            if (!dialogue_is_fully_typed) { // Still typing
                typewriter_counter += 1;
                if (typewriter_counter >= typewriter_speed) {
                    typewriter_counter = 0;
                    // Increment typewriter_index, but cap it at the total length to prevent errors
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

        // --- Existing Dialogue Progression Logic ---
        switch (cutscene_step) {
            case 0:
                if (dialogue_stage == 0 && !dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "Distant shouting can be heard from the living room. The air feels heavy.";
                    dialogue_visible = true;
                }
                else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 1;
                    dialogue_speaker = "Mother";
                    current_dialogue = "You promised you'd be home for dinner last night. Our daughter waited up again!";
                    reset_typewriter();
                }
                else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 2;
                    dialogue_speaker = "Father";
                    current_dialogue = "I have deadlines. You think I want to work this much? I’m doing this for us.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 3;
                    dialogue_speaker = "Mother";
                    current_dialogue = "For us? We haven’t had a real conversation in months. You barely know what’s happening in this house.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 3 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 4;
                    dialogue_speaker = "Father";
                    current_dialogue = "Because every time I walk through the door, it’s like I’m walking into a war zone!";
                    reset_typewriter();
                }
                else if (dialogue_stage == 4 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 5;
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "They’re at it again. Always before school, like a broken alarm clock that only knows how to shout.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 5 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 6;
                    dialogue_speaker = "Mother";
                    current_dialogue = "She’s slipping. I see it. She hardly eats. She’s falling behind. She doesn’t talk to me anymore.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 6 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 7;
                    dialogue_speaker = "Father";
                    current_dialogue = "Because she doesn’t talk to me either! I come home and she’s either asleep or staring at her phone like a stranger.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 7 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 8;
                    dialogue_speaker = "Mother";
                    current_dialogue = "She’s not a machine you just plug in and expect to perform. She needs us. Not just your paycheck. You.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 8 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 9;
                    dialogue_speaker = "Father";
                    current_dialogue = "You think I don’t feel guilty? I’m trying. But everything I do feels like it’s never enough... for either of you.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 9 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 10;
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "They always forget I can hear everything. Maybe they think I’m still asleep.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 10 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    cutscene_step = 1;
                    dialogue_stage = 0;
                    dialogue_visible = false;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You walk outside your room like someone trying not to exist too loudly.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    cutscene_step = 2;
                    dialogue_visible = false;
                    room_goto(house_day1_scene1_1);
                }
                break;

            case 2:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "I heard everything.", // Direct, firm → -1
                        "It’s fine. I’m just getting ready.", // Withdrawn → 0
                        "You guys done?" // Flat tone → -2
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
                        else if (choice_selected == 2) player_mood -= 2;

                        global.player_mood = player_mood;
                        cutscene_step = 3;
                    }
                }
                break;

            case 3:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 4;
                    dialogue_stage = 0;
                }
                break;

            case 4:
                if (dialogue_stage == 0 && !dialogue_visible) {
                    dialogue_speaker = "Mother";
                    current_dialogue = "We didn’t mean for you to… hear that.";
                    dialogue_visible = true;
                }
                else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 1;
                    dialogue_speaker = "Mother";
                    current_dialogue = "Do you want me to walk you to the jeep stop…? Just for a few minutes?";
                    reset_typewriter();
                }
                else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 2;
                    dialogue_speaker = "You";
                    current_dialogue = "No. I’ll be fine.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    cutscene_step = 5;
                    dialogue_visible = false;
                }
                break;

            case 5:
                if (!dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You step outside. Walking down the cracked steps, adjusting the strap of your bag.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    global.cutscene_id = 1;
                    global.cutscene_active = true;
                    dialogue_visible = false;
                    reset_typewriter();
                    room_goto(school_day1_scene1);
                }
                break;
        }
        break;
}
