// ===============================================================
// SCRIPT 2: Remainder of the Scene (Standalone)
// ===============================================================

// --- Fade-in and Typewriter Logic ---
if (fade_alpha > 0) fade_alpha -= 0.02;

if (global.dialogue_visible) {
    var total_dialogue_length = string_length(current_dialogue);
    var dialogue_is_fully_typed = (typewriter_index >= total_dialogue_length);

    if (!dialogue_is_fully_typed) { // Still typing
        typewriter_counter += 1;
        if (typewriter_counter >= typewriter_speed) {
            typewriter_counter = 0;
            typewriter_index = min(typewriter_index + 1, total_dialogue_length);
            displayed_text = string_copy(current_dialogue, 1, typewriter_index);
        }
    } else { // Typing finished
        displayed_text = current_dialogue;
    }
} else { // Dialogue not visible, reset
    typewriter_index = 0;
    displayed_text = "";
    typewriter_counter = 0;
}

// --- Handle Dialogue Skip with Space Key ---
if (global.dialogue_visible && keyboard_check_pressed(vk_space) && typewriter_index < string_length(current_dialogue)) {
    typewriter_index = string_length(current_dialogue);
    displayed_text = current_dialogue;
    exit;
}

// --- Scene Progression (With Automatic Movement) ---
switch (cutscene_step) {
    case 0: // Formerly case 1
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You reach the classroom before the bell. Casey’s already there, flipping through a notebook. She glances up when you walk in.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            
            // --- START MC MOVEMENT ---
            // Tell the main character object to move to a target position
            with (obj_MC) {
                // !! SET YOUR TARGET COORDINATES HERE !!
                target_x = 464; // Example: Move right by 64 pixels
                target_y = obj_Casey.y;      // Example: Keep current y
                is_moving_automatically = true;
            }
            
            // Go to the new waiting step
            cutscene_step = 0.5;
        }
        break;

    // --- NEW: WAITING STEP FOR MC MOVEMENT ---
    case 0.5:
        // Wait here until the MC instance confirms it has stopped moving
        if (!instance_exists(obj_MC) || !obj_MC.is_moving_automatically) {
            // Now that movement is done, proceed to the next dialogue step
            cutscene_step = 1;
        }
        break;

    case 1: // Formerly case 2
        if (!global.dialogue_visible) {
            dialogue_speaker = "Casey";
            current_dialogue = "You look… kinda less haunted today. That progress?";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 2;
        }
        break;

    case 2: // Formerly case 3
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "Maybe. I slept. That’s something.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;

    case 3: // Formerly case 4
        if (!global.dialogue_visible) {
            dialogue_speaker = "Casey";
            current_dialogue = "That is something. You don’t have to tell me stuff, but… if you ever feel like it, I’m not terrible at listening.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4;
        }
        break;

    case 4: // Formerly case 5
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You hesitate. Then sit down beside her, feeling the weight of the offer, but also the comfort in it.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            choice_made = false;
            cutscene_step = 5;
        }
        break;

    case 5: // Formerly case 6
        if (!choice_made && !choice_active) {
            choice_options = [
                "There’s stuff going on, yeah. Hard to explain.",
                "It’s just… Been tense at home. Like walking on glass.",
                "I’m fine. Just tired, that’s all."
            ];
            choice_selected = 0;
            choice_active = true;
        }
        else if (choice_active) {
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
                current_dialogue = choice_options[choice_selected];
                global.dialogue_visible = true;

                if (choice_selected == 0) player_mood += 1;
                else if (choice_selected == 1) player_mood += 2;
                else if (choice_selected == 2) player_mood -= 1;
                global.player_mood = player_mood;
                cutscene_step = 5.5;
            }
        }
        break;

    case 5.5: // Formerly case 6.5
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 6;
        }
        break;

    case 6: // Formerly case 7
        if (!global.dialogue_visible) {
            dialogue_speaker = "Casey";
            current_dialogue = "Well… just know I’ve got snacks and sarcasm if you need either.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 7;
        }
        break;

    case 7: // Formerly case 8
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "She smiles again, and for a moment, it feels easier to smile back.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 8;
        }
        break;
        
    case 8: // Formerly case 9
        if (!global.dialogue_visible) {
            global.cutscene_active = true;
            room_goto(room_Day3_Scene4_1); // move to next room/scene
            instance_destroy();
        }
        break;
}