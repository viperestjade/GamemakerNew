// In obj_controller_scene1 -> Step Event

// --- Fade-in Logic ---
if (fade_alpha > 0) fade_alpha -= 0.02;

// --- Typewriter & Skip Logic ---
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
            displayed_text = string_copy(current_dialogue, 1, typewriter_index);
        }
    }
    displayed_text = string_copy(current_dialogue, 1, typewriter_index);
} else {
    typewriter_index = 0;
    displayed_text = "";
    typewriter_counter = 0;
}

// --- Dialogue Progression ---
switch (cutscene_step) {
    
    case 0: // Intro Dialogue
        if (dialogue_stage == 0 && !global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "You’re up early, honey...";
            global.dialogue_visible = true;
            reset_typewriter();
			portrait_sprite = spr_Profile_Mother;
        }
        else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            dialogue_stage = 1;
            dialogue_speaker = "Father";
            current_dialogue = "…Hey, honey";
			portrait_sprite = spr_Profile_Father;
            reset_typewriter();
        }
        else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            cutscene_step = 1;
            global.dialogue_visible = false;
        }
        break;

    case 1: // The Choice
        if (!choice_made && !choice_active) {
            choice_options = ["I heard everything.", "It’s fine. I’m just getting ready.", "You guys done?"];
            choice_selected = 0;
            choice_active = true;
			portrait_sprite = -1;
        }
        else if (choice_active) {
            if (keyboard_check_pressed(ord("S"))) choice_selected = (choice_selected + 1) % array_length(choice_options);
            if (keyboard_check_pressed(ord("W"))) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
            
            if (keyboard_check_pressed(ord("E"))) {
                choice_made = true;
                choice_active = false;
                dialogue_speaker = "You";
				portrait_sprite = spr_Profile_MC;
                current_dialogue = choice_options[choice_selected];
                global.dialogue_visible = true;
                
                if (choice_selected == 0) global.player_mood -= 1;
                else if (choice_selected == 2) global.player_mood -= 2;
                
                reset_typewriter();
                cutscene_step = 2;
            }
        }
        break;

    case 2: // Wait after choice
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
            dialogue_stage = 0;
			portrait_sprite = -1;
        }
        break;

    case 3: // Parents' reaction
        if (dialogue_stage == 0 && !global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "We didn’t mean for you to… hear that.";
			portrait_sprite = spr_Profile_MotherD;
            global.dialogue_visible = true;
        }
        else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            dialogue_stage = 1;
            dialogue_speaker = "Mother";
            current_dialogue = "Do you want me to walk you to the jeep stop…? Just for a few minutes?";
			portrait_sprite = spr_Profile_MotherD;
            reset_typewriter();
        }
        else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            dialogue_stage = 2;
            dialogue_speaker = "You";
            current_dialogue = "No. I’ll be fine.";
			portrait_sprite = spr_Profile_MC;
            reset_typewriter();
        }
		 else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            dialogue_stage = 3;
            dialogue_speaker = "Narration";
            current_dialogue = "You step outside. Walking down the cracked steps, adjusting the strap of your bag.";
            portrait_sprite = -1;
			reset_typewriter();
        }
        // --- MODIFIED: This is now the end of the scene ---
        else if (dialogue_stage == 3 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            global.cutscene_active = false; // Give control to the player
        }
        break;
}