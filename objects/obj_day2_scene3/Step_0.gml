// --- Fade-in, Typewriter, and Skip Logic ---
if (fade_alpha > 0) fade_alpha -= 0.02;

if (global.dialogue_visible) {
    var total_dialogue_length = string_length(current_dialogue);
    
    if (typewriter_index < total_dialogue_length) {
        if (keyboard_check_pressed(vk_space)) {
            typewriter_index = total_dialogue_length;
            exit; // Exit script for this frame to show full text immediately
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
    case 0: // Opening narration
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The bell rings, but today, it doesn’t feel like the usual signal to start a class. You slip into your seat, trying to avoid the gaze of anyone nearby. The room hums with chatter, but your mind feels far away, distant from the buzz of everyday school life.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1: // Second narration, triggers teacher movement
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You can’t focus on anything. The teacher’s voice seems like it’s coming from underwater, and the words just blur into a stream of noise.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            
            // --- START OF TEACHER MOVEMENT ---
            with (obj_Teacher) {
                target_x = 415; 
                target_y = self.y;
                is_moving_automatically = true;
            }
            
            cutscene_step = 1.2;
        }
        break;

    case 1.2: // Wait for first movement
        if (!instance_exists(obj_Teacher) || !obj_Teacher.is_moving_automatically) {
            with (obj_Teacher) {
                target_x = self.x;
                target_y = obj_MC.y;
                is_moving_automatically = true;
            }
            cutscene_step = 1.4;
        }
        break;
        
    case 1.4: // Wait for second movement
        if (!instance_exists(obj_Teacher) || !obj_Teacher.is_moving_automatically) {
            cutscene_step = 2;
        }
        break;

    case 2: // Teacher dialogue
        if (!global.dialogue_visible) {
            dialogue_speaker = "Teacher";
            current_dialogue = "Hey, you doing alright? You’ve been kind of quiet today.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_TeacherT;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;

    case 3: // Narration after teacher speaks
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "Your teacher's concern catches you off guard. You shrug, not feeling like explaining anything right now. You hope they'll drop it, but the teacher lingers for a moment, scanning you carefully.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4;
        }
        break;

    case 4: // First player choice
        if (!choice_made && !choice_active) {
            choice_options = [
                "Just got some stuff on my mind.",
                "I’m fine. Don’t worry about me.",
                "I’m fine, just tired."
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
                else if (choice_selected == 1) player_mood -= 1;
                
                global.player_mood = player_mood;
                cutscene_step = 4.5;
            }
        }
        break;

    case 4.5: // Wait for player to read their choice
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 5;
        }
        break;

    case 5: // Final narration and transition
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You sink further into your seat, feeling like you’re on the edge of being seen, like you’re being watched but don’t want to be found. Your mind starts to wander. The thought of talking to someone, anyone, feels like a mountain you’re too tired to climb.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            room_goto(room_Day2_Scene4); // Transition to the next room (lunch scene)
            instance_destroy(); // Clean up this controller
        }
        break;
}