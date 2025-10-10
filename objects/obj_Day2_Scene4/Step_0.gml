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

// --- Scene Progression ---
switch (cutscene_step) {
    case 0: // Opening narration for lunch scene
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The lunch bell rings, and you head outside, but something’s different. You catch Casey’s eyes as she walks by. She slows down, hesitating for a second before making her way over to you.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            
            // --- START OF CASEY'S MOVEMENT ---
            with (obj_Casey) {
                // !! 1. SET THE FIRST TARGET to avoid collision
                // Replace with your desired coordinates
                target_x = self.x; 
                target_y = obj_MC.y;
                is_moving_automatically = true;
            }
            cutscene_step = 0.2; // Go to the first waiting step
        }
        break;

    // --- NEW: WAIT FOR CASEY'S MOVEMENT ---
    case 0.2: // WAIT FOR FIRST MOVE
        if (!instance_exists(obj_Casey) || !obj_Casey.is_moving_automatically) {
            // --- First move is done, start the second move ---
            with (obj_Casey) {
                // !! 2. SET THE FINAL TARGET (e.g., next to the player)
                // Replace with your desired coordinates
                target_x = 255;
                target_y = self.y;
                is_moving_automatically = true;
            }
            cutscene_step = 0.4; // Go to the second waiting step
        }
        break;
        
    case 0.4: // WAIT FOR SECOND MOVE
        if (!instance_exists(obj_Casey) || !obj_Casey.is_moving_automatically) {
            // --- All movement is done, continue the dialogue ---
            cutscene_step = 1;
        }
        break;
    // --- END OF NEW CODE ---

    case 1: // Casey's first line
        if (!global.dialogue_visible) {
            dialogue_speaker = "Casey";
            current_dialogue = "Hey, you okay? You’re not usually this... quiet.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_CaseyT;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            choice_made = false; // Reset for the next choice
            cutscene_step = 2;
        }
        break;

    case 2: // Second player choice
        if (!choice_made && !choice_active) {
            choice_options = [
                "Honestly, I’m not okay. I don’t even know where to start.",
                "Why are you asking? It’s not like it’s any of your business.",
                "Yeah, just a lot on my mind. Nothing big."
            ];
            choice_selected = 0;
            choice_active = true;
        }
        else if (choice_active) {
            // Choice navigation
            if (keyboard_check_pressed(ord("S"))) choice_selected = (choice_selected + 1) % array_length(choice_options);
            if (keyboard_check_pressed(ord("W"))) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
            
            // Choice confirmation
            if (keyboard_check_pressed(ord("E"))) {
                choice_made = true;
                choice_active = false;
                dialogue_speaker = "You";
				portrait_sprite = spr_Profile_MC;
                current_dialogue = choice_options[choice_selected];
                global.dialogue_visible = true;
                
                if (choice_selected == 0) player_mood += 1;
                else if (choice_selected == 1) player_mood -= 2;

                global.player_mood = player_mood;
                cutscene_step = 2.5;
            }
        }
        break;

    case 2.5: // Wait for player to read their choice
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;

    case 3: // Casey's response
        if (!global.dialogue_visible) {
            dialogue_speaker = "Casey";
            current_dialogue = "Well ok but if you ever want to talk, I’m here. You don’t have to go through this alone, you know?";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_CaseyT;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4;
        }
        break;

    case 4: // Transition to the next scene
        room_goto(room_Day2_Scene5);
        instance_destroy(); // Clean up this controller
        break;
}