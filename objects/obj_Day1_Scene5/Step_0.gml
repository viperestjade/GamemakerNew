// --- Fade-in, Typewriter, and Skip Logic ---
if (fade_alpha > 0) fade_alpha -= 0.02;

if (global.dialogue_visible) {
    var total_dialogue_length = string_length(current_dialogue);
    if (typewriter_index < total_dialogue_length) {
        if (keyboard_check_pressed(vk_space)) {
            typewriter_index = total_dialogue_length;
            exit;
        }
        typewriter_counter += 1;
        if (typewriter_counter >= typewriter_speed) {
            typewriter_counter = 0;
            typewriter_index = min(typewriter_index + 1, total_dialogue_length);
        }
    }
    displayed_text = string_copy(current_dialogue, 1, typewriter_index);
} else {
    typewriter_index = 0;
    displayed_text = "";
    typewriter_counter = 0;
}

// --- Dialogue Progression ---
if (!choice_active) {
    if (dialogue_stage == 0 && !global.dialogue_visible) {
        dialogue_speaker = "Narration";
        current_dialogue = "You walk in, expecting silence, but hear movement from the kitchen.";
        global.dialogue_visible = true;
        reset_typewriter();
    }
    else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 1;
        dialogue_speaker = "Narration";
        current_dialogue = "Your mom is there, still in her work clothes, stirring something on the stove. She doesn’t turn around, but she knows it’s you.";
        reset_typewriter();
    }
    else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 2;
        dialogue_speaker = "Mother";
        current_dialogue = "You’re back early.";
        reset_typewriter();
    }
    else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 3;
        dialogue_speaker = "You";
        current_dialogue = "School ended. Same as always.";
        reset_typewriter();
    }
    else if (dialogue_stage == 3 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 4;
        dialogue_speaker = "Narration";
        current_dialogue = "She nods but doesn’t say anything else right away. The kitchen smells like something warm, maybe soup. You stand awkwardly at the edge of the doorway, backpack still on.";
        reset_typewriter();
    }
    else if (dialogue_stage == 4 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 5;
        dialogue_speaker = "Mother";
        current_dialogue = "I made mushroom soup. You still like that, right?";
        reset_typewriter();
    }
    else if (dialogue_stage == 5 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 6;
        dialogue_speaker = "You";
        current_dialogue = "Yeah. Thanks.";
        reset_typewriter();
    }
    else if (dialogue_stage == 6 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 7;
        dialogue_speaker = "Mother";
        current_dialogue = "You didn’t say much this morning. I know it was loud again.";
        reset_typewriter();
    }
    
    // --- STAGE 7: TRIGGER MOVEMENT ---
    // At the end of this dialogue, we hide the text box and start the movement.
    else if (dialogue_stage == 7 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        // 1. Hide the dialogue box
        global.dialogue_visible = false;
        
        // 2. Give the move order to the player object.
        with (obj_MC) {
            target_x = 320; // The chair's X coordinate
            target_y = 336; // The chair's Y coordinate
            is_moving_automatically = true;
        }

        // 3. Advance to the "waiting" stage
        dialogue_stage = 8;
    }

    // --- STAGE 8: WAIT FOR MOVEMENT TO FINISH ---
    // This stage has no text and doesn't wait for input. It just checks if the MC has stopped.
    else if (dialogue_stage == 8) {
        if (!obj_MC.is_moving_automatically) {
            // 1. Movement is done. Resume the dialogue.
            global.dialogue_visible = true;
            
            // 2. Set the next line of dialogue.
            dialogue_speaker = "Narration";
            current_dialogue = "You sit down and start eating. She leans against the counter, arms crossed.";
            reset_typewriter();
            
            // 3. Advance to the next dialogue stage.
            dialogue_stage = 9;
        }
    }

    // --- SUBSEQUENT STAGES (RENUMBERED) ---
    // Note: All following stages are incremented by 1.
    else if (dialogue_stage == 9 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 10;
        dialogue_speaker = "Mother";
        current_dialogue = "Your dad says he’s doing it for us. Maybe that’s true. But it’s not enough, is it?";
        reset_typewriter();
    }
    else if (dialogue_stage == 10 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 11;
        dialogue_speaker = "Narration";
        current_dialogue = "You glance at her. She looks tired, not just from the day, but from months of holding things together with frayed strings.";
        reset_typewriter();
    }
    else if (dialogue_stage == 11 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 12; // Stage for initiating the choice
        choice_options = [
            "I don’t even know what’s enough anymore.",
            "Say nothing",
            "You’re doing more than either of us knows how to say."
        ];
        choice_selected = 0;
        choice_active = true;
        global.dialogue_visible = false;
    }
    else if (dialogue_stage == 13 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 14;
        dialogue_speaker = "Narration";
        current_dialogue = "She doesn't respond, but her eyes soften just a little before she looks away.";
        reset_typewriter();
    }
    else if (dialogue_stage == 14 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 15;
        dialogue_speaker = "Narration";
        current_dialogue = "You finish your soup in silence. She lets you leave without more questions.";
        reset_typewriter();
    }
    else if (dialogue_stage == 15 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 16;
        dialogue_speaker = "Narration";
        current_dialogue = "As you step out of the kitchen, the quiet isn’t peaceful, it’s just quiet. No yelling, no plates clattering, no harsh words. But the space between you all still feels heavy.";
        reset_typewriter();
    }
    else if (dialogue_stage == 16 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 17;
        dialogue_speaker = "Narration";
        current_dialogue = "You head back to your room. Not to escape but to breathe.";
        reset_typewriter();
    }
    else if (dialogue_stage == 17 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 18;
        if (global.player_mood > 0) {
            current_dialogue = "The air in the kitchen, once so heavy with silence, now feels a little less suffocating. It’s not a fix, but it’s a moment of shared understanding. You head to your room, the quiet no longer feeling like a wall but like a truce. For the first time, you feel like maybe the next morning won't be a repeat of the last.";
        } else {
            current_dialogue = "You finish your soup in silence. The air feels heavy again, the unspoken words weighing on both of you. You head to your room, the quiet not peaceful, just quiet. It's a silence that promises more of the same tomorrow.";
        }
        reset_typewriter();
    }
    else if (dialogue_stage == 18 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        global.cutscene_active = false;
        // --- CHANGE THE ROOM HERE ---
        room_goto(Day_2);
    }
}
else { // Handle choice input
    if (keyboard_check_pressed(ord("S"))) choice_selected = (choice_selected + 1) % array_length(choice_options);
    if (keyboard_check_pressed(ord("W"))) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
    
    if (keyboard_check_pressed(ord("E"))) {
        choice_made = true;
        choice_active = false;
        
        if (choice_selected == 0) player_mood -= 1;
        else if (choice_selected == 1) player_mood -= 2;
        else if (choice_selected == 2) player_mood += 2;
        global.player_mood = player_mood;
        
        global.dialogue_visible = true;
        dialogue_stage = 13; // Set stage to continue after choice is made
    }
}