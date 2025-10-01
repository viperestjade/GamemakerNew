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
    case 0:
        if (fade_alpha > 0) fade_alpha -= 0.02;
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "Both your parents are in the living room.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mom";
            current_dialogue = "Hey. You’re home a little later today.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 2;
        }
        break;

    case 2:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Dad";
            current_dialogue = "Everything alright?";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;

    case 3:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You hesitate. Then take off your shoes. Drop your bag and step further into the room.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            
            with (obj_MC) {
                target_x = 496;
                target_y = obj_Father.y;
                is_moving_automatically = true;
            }
            
            cutscene_step = 3.5;
        }
        break;

    case 3.5:
        if (!instance_exists(obj_MC) || !obj_MC.is_moving_automatically) {
            cutscene_step = 4;
        }
        break;

    case 4:
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "Yeah. Just… stayed behind to talk to someone.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 5;
        }
        break;

    case 5:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "Your mom shifts in her seat. You notice the flicker in her eyes, concern, maybe, or relief.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 6;
        }
        break;
        
    case 6:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mom";
            current_dialogue = "That’s good. Talking, I mean.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 7;
        }
        break;
        
    case 7:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Dad";
            current_dialogue = "We’ve noticed you’ve been… quiet lately. We didn’t want to push. But we’re here. If you ever want to talk.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 8;
        }
        break;
        
    case 8:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The room is quiet, but not tense. The warmth of the lamp in the corner wraps around the room like a soft blanket.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 9;
        }
        break;

    case 9:
        if (!global.dialogue_visible) {
            global.cutscene_active = true;
            
            // --- MODIFIED ENDING ---
            // Check player mood to decide which room to go to
            if (global.player_mood >= 5) {
                global.ending_type = "good";
                // !! REPLACE 'room_good_ending' WITH YOUR ACTUAL ROOM NAME !!
                room_goto(room_Day3_Scene7A); 
            } else {
                global.ending_type = "bad";
                // !! REPLACE 'room_bad_ending' WITH YOUR ACTUAL ROOM NAME !!
                room_goto(room_Day3_Scene7B);
            }
            
            instance_destroy(); // This happens after the room transition is queued
        }
        break;
}