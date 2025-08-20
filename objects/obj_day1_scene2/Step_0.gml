if (room == Matching_Game) {
    exit; 
}

// --- Cutscene ID Check (decides which cutscene to run)
switch (global.cutscene_id) {

	case 1: // Cutscene 2: First Period Fog
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
                if (dialogue_stage == 0 && !dialogue_visible) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "Bell rings faintly. Students chatter and shuffle through the school gates. You walk in, bag slung over one shoulder.";
                    dialogue_visible = true;
                }
                else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 1;
                    dialogue_speaker = "Narration";
                    current_dialogue = "You don’t really look around much, just head straight in, eyes low.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 2;
                    dialogue_speaker = "Narration";
                    current_dialogue = "A few classmates are already hanging out near the canteen, laughing about something that probably isn’t funny unless you were there for the start of the joke.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 3;
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "Feels like everyone else had a normal morning. I wonder if anyone else had to walk past a war zone just to get here.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 3 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 4;
                    dialogue_speaker = "Narration";
                    current_dialogue = "You reach your classroom and slide into your usual seat near the window. It’s a decent spot, quiet and out of the way.";
                    room_goto(school_day1_scene1_1);
                    reset_typewriter();
                }
                else if (dialogue_stage == 4 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 5;
                    dialogue_speaker = "Narration";
                    current_dialogue = "You rest your arms on the desk, checking your phone. No messages.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 5 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 6;
                    dialogue_speaker = "Narration";
                    current_dialogue = "The teacher walks in, carrying a stack of papers and a kind of forced smile.";
                    room_goto(school_day1_scene1_2);
                    reset_typewriter();
                }
                else if (dialogue_stage == 6 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 7;
                    dialogue_speaker = "Teacher";
                    current_dialogue = "Alright, before we dive into lectures, we’re doing something different today. Group reflection activity.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 7 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 8;
                    dialogue_speaker = "Teacher";
                    current_dialogue = "Don’t panic, no tests. Just thoughts.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 8 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 9;
                    dialogue_speaker = "Narration";
                    current_dialogue = "A few students groan. One kid says, “Can we skip this?”";
                    reset_typewriter();
                }
                else if (dialogue_stage == 9 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 10;
                    dialogue_speaker = "Teacher";
                    current_dialogue = "Nope. You’ll be working in pairs. Talk about what’s been stressing you out lately, and more importantly, how you deal with it.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 10 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 11;
                    dialogue_speaker = "Teacher";
                    current_dialogue = "Be honest, or pretend to be. Up to you.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 11 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 12;
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "She’s pointing a finger at me?";
                    reset_typewriter();
                }
                else if (dialogue_stage == 12 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 13;
                    dialogue_speaker = "Teacher";
                    current_dialogue = "You and Casey. Back row.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 13 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_stage = 14;
                    dialogue_speaker = "Inner Thought";
                    current_dialogue = "Oh.";
                    reset_typewriter();
                }
                else if (dialogue_stage == 14 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    cutscene_step = 1;
                    dialogue_visible = false;
                }
                break;

            case 1:
                if (!dialogue_visible) {
                    dialogue_speaker = "Casey";
                    current_dialogue = "Guess we’re stress buddies for today.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_visible = false;
                    cutscene_step = 1.5;
                }
                break;

            case 1.5:
                if (!dialogue_visible) {
                    dialogue_speaker = "Casey";
                    current_dialogue = "You good to start, or wanna flip a coin?";
                    dialogue_visible = true;
                    cutscene_step = 1.6;
                }
                break;

            case 1.6:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
					room_goto(Matching_Game);
                    dialogue_visible = false;
                    cutscene_step = 2;
                }
                break;

            case 2:
                if (!choice_made && !choice_active) {
                    choice_options = [
                        "Honestly? Been rough at home. It’s kinda hard to focus on anything else right now.", // +2
                        "I mean, my stress coping strategy is caffeine and ignoring deadlines. So... A+ student, clearly.", // +1
                        "You can go first. I’m still figuring out what I’d even say." // +0
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

                        if (choice_selected == 0) player_mood += 2;
                        else if (choice_selected == 1) player_mood += 1;

                        global.player_mood = player_mood;
                        cutscene_step = 3;
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
                    dialogue_speaker = "Casey";
                    current_dialogue = "Fair enough. Mine’s mostly school. Plus some stuff at home, but... whatever.";
                    dialogue_visible = true;
                }
                else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "She doesn’t press, which is kind of a relief.";
                    reset_typewriter();
                    cutscene_step = 5;
                }
                break;

            case 5:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You both skim the worksheet in silence for a few seconds before she offers a small smile.";
                    reset_typewriter();
                    cutscene_step = 6;
                }
                break;

            case 6:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_speaker = "Casey";
                    current_dialogue = "This stuff’s weird, right? Like… writing down how messed up we feel, and then what? Still gotta finish homework after.";
                    reset_typewriter();
                    cutscene_step = 7;
                }
                break;

            case 7:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    dialogue_speaker = "Narration";
                    current_dialogue = "You give a small laugh, the first one today. It doesn’t fix anything, but for a moment, it feels like someone finally gets it.";
                    reset_typewriter();
                    cutscene_step = 8;
                }
                break;

            case 8:
                if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
                    global.cutscene_id = 2;
                    global.cutscene_active = true;
                    dialogue_visible = false;
                    room_goto(house_day1_scene2); // Replace with your next actual room name
                }
                break;
        }
        break;
}
