// In obj_controller_classroom -> Step Event

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
if (!choice_active) { // Only advance dialogue if not in a choice menu
    if (dialogue_stage == 0 && !global.dialogue_visible) {
        dialogue_speaker = "Narration";
        current_dialogue = "You reach your classroom and slide into your usual seat near the window. It’s a decent spot, quiet and out of the way.";
        global.dialogue_visible = true;
		portrait_sprite = -1;
        reset_typewriter();
    }
    else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 1;
        dialogue_speaker = "Narration";
        current_dialogue = "You rest your arms on the desk, checking your phone. No messages.";
		portrait_sprite = -1;
        reset_typewriter();
    }
    else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 2;
        dialogue_speaker = "Narration";
        current_dialogue = "The teacher walks in, carrying a stack of papers and a kind of forced smile.";
		portrait_sprite = -1;
        reset_typewriter();
    }
    else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 3;
        dialogue_speaker = "Teacher";
        current_dialogue = "Alright, before we dive into lectures, we’re doing something different today. Group reflection activity.";
        portrait_sprite = spr_Profile_Teacher;
		reset_typewriter();
    }
    else if (dialogue_stage == 3 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 4;
        dialogue_speaker = "Teacher";
        current_dialogue = "Don’t panic, no tests. Just thoughts.";
		portrait_sprite = spr_Profile_TeacherT;
        reset_typewriter();
    }
    else if (dialogue_stage == 4 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 5;
        dialogue_speaker = "Narration";
        current_dialogue = "A few students groan. One kid says, “Can we skip this?”";
		portrait_sprite = -1;
        reset_typewriter();
    }
    else if (dialogue_stage == 5 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 6;
        dialogue_speaker = "Teacher";
        current_dialogue = "Nope. You’ll be working in pairs. Talk about what’s been stressing you out lately, and more importantly, how you deal with it.";
        portrait_sprite = spr_Profile_TeacherT;
		reset_typewriter();
    }
    else if (dialogue_stage == 6 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 7;
        dialogue_speaker = "Teacher";
        current_dialogue = "Be honest, or pretend to be. Up to you.";
		portrait_sprite = spr_Profile_TeacherT;
        reset_typewriter();
    }
    else if (dialogue_stage == 7 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 8;
        dialogue_speaker = "Inner Thought";
        current_dialogue = "She’s pointing a finger at me?";
		portrait_sprite = spr_Profile_IT;
        reset_typewriter();
    }
    else if (dialogue_stage == 8 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 9;
        dialogue_speaker = "Teacher";
        current_dialogue = "You and Casey. Back row.";
		portrait_sprite = spr_Profile_TeacherT;
        reset_typewriter();
    }
    else if (dialogue_stage == 9 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 10;
        dialogue_speaker = "Inner Thought";
        current_dialogue = "Oh.";
		portrait_sprite = spr_Profile_IT;
        reset_typewriter();
    }
    else if (dialogue_stage == 10 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 11;
        dialogue_speaker = "Casey";
        current_dialogue = "Guess we’re stress buddies for today.";
		portrait_sprite = spr_Profile_Casey;
        reset_typewriter();
    }
    else if (dialogue_stage == 11 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 12;
        dialogue_speaker = "Casey";
        current_dialogue = "You good to start, or wanna flip a coin?";
		portrait_sprite = spr_Profile_CaseyT;
        reset_typewriter();
    }
    else if (dialogue_stage == 12 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 13;
        choice_options = [
            "Honestly? Been rough at home. It’s kinda hard to focus on anything else right now.",
            "I mean, my stress coping strategy is caffeine and ignoring deadlines. So... A+ student, clearly.",
            "You can go first. I’m still figuring out what I’d even say."
        ];
        choice_selected = 0;
        choice_active = true;
        global.dialogue_visible = false;
    }
    else if (dialogue_stage == 13 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        dialogue_stage = 14;
        dialogue_speaker = "Casey";
        current_dialogue = "Fair enough. Mine’s mostly school. Plus some stuff at home, but... whatever.";
        portrait_sprite = spr_Profile_CaseyT;
		reset_typewriter();
    }
    // --- MODIFIED: This is now the end of the scene ---
    else if (dialogue_stage == 14 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
        // Instead of ending the cutscene, go to the next room.
        room_goto(room_Day1_Scene5);
    }
}
else { // Handle choice input
    if (keyboard_check_pressed(ord("S"))) choice_selected = (choice_selected + 1) % array_length(choice_options);
    if (keyboard_check_pressed(ord("W"))) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
    
    if (keyboard_check_pressed(ord("E"))) {
        choice_made = true;
        choice_active = false;
        
        if (choice_selected == 0) player_mood += 2;
        else if (choice_selected == 1) player_mood += 1;
        global.player_mood = player_mood;
        
        global.dialogue_visible = true;
        dialogue_stage = 13; // Go to Casey's reaction
    }
}