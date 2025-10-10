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

// --- Kitchen Dialogue Progression ---
switch (cutscene_step) {
    case 0: // Start of the kitchen scene
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "I made eggs. You’ve got time, if you want to eat.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_Mother;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1: // Present the choice to the player
        if (!choice_active) {
            choice_options = [
                "Thanks, I’ll eat.",
                "I’m not hungry. Maybe later.",
                "I’m good, but I appreciate it."
            ];
            choice_selected = 0;
            choice_active = true;
        }
        if (choice_active) {
            if (keyboard_check_pressed(ord("S"))) {
                choice_selected = (choice_selected + 1) % array_length(choice_options);
            }
            if (keyboard_check_pressed(ord("W"))) {
                choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
            }
            if (keyboard_check_pressed(ord("E"))) {
                choice_made = true;
                choice_active = false;
                dialogue_speaker = "You";
				portrait_sprite = spr_Profile_MC;
                current_dialogue = choice_options[choice_selected];
                global.dialogue_visible = true;
                if (choice_selected == 0) player_mood += 1;
                else if (choice_selected == 1) player_mood -= 1;
                global.player_mood = player_mood;
                cutscene_step = 1.5;
            }
        }
        break;

    case 1.5: // After choice dialogue, trigger the movement
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;

            // Give the move order to the player object
            with (obj_MC) {
                // !! SET THE COORDINATES FOR THE CHAIR AT THE KITCHEN TABLE
                target_x = 320; // Example X
                target_y = 336; // Example Y
                is_moving_automatically = true;
            }
            
            // Advance to the new "waiting" step
            cutscene_step = 1.7;
        }
        break;
        
    case 1.7: // NEW: Wait for the player to finish moving
        if (!instance_exists(obj_MC) || !obj_MC.is_moving_automatically) {
            // Movement is done, continue the scene
            cutscene_step = 2;
        }
        break;

    case 2:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You sit down at the small kitchen table. Your mom is still standing at the stove, her movements slow and mechanical, like she's trying to avoid saying anything else.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 2.5;
        }
        break;
        
    case 2.5:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The eggs sit in front of you, warm but unappealing. The house is quieter than usual, no loud arguments or tension filling the space, just the soft hum of the kitchen and the muted clatter of your mom’s movements.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;
        
    case 3:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "I’ll try to be home earlier today. I know things haven’t been easy for either of us.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_MotherD;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3.5;
        }
        break;

    case 3.5:
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "Okay";
			portrait_sprite = spr_Profile_MC;
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4;
        }
        break;

    case 4:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "No words need to be said. Your mom doesn’t press you, and you don’t press her either. It’s just quiet, the kind of quiet that feels like waiting for something, but you’re not sure what.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4.5;
        }
        break;

    case 4.5:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "After a few moments, you stand up, gathering your bag, and as you head for the door, your mom watches you with those tired eyes of hers. She doesn’t say anything else, just nods.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 5;
        }
        break;

    case 5: // Final step of the scene
        global.cutscene_active = false;
        room_goto(room_Day2_Scene3);
        break;
}