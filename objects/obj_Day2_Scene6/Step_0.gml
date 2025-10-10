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

// --- Dialogue Skip Logic ---
if (global.dialogue_visible && keyboard_check_pressed(vk_space) && typewriter_index < string_length(current_dialogue)) {
    typewriter_index = string_length(current_dialogue);
    displayed_text = current_dialogue;
    exit; // Prevents advancing dialogue in the same frame
}

// --- Scene Progression ---
switch (cutscene_step) {
    case 0:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "There’s stew on the stove. You can heat some up if you’re hungry.";
			portrait_sprite = spr_Profile_Mother;
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Father";
            current_dialogue = "Long day?";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_Father;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 2;
        }
        break;

    case 2:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "It’s the first thing he’s said to you in a while. It doesn’t demand a reply, just leaves space for one if you want it.";
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
            dialogue_speaker = "Narration";
            current_dialogue = "You give a small shrug. Not because you’re trying to shut them out, but because you don’t know what to say yet.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            
            // --- START MC MOVEMENT ---
            with (obj_MC) {
                // Replace with your desired coordinates (e.g., a small shuffle)
                target_x = 320; 
                target_y = 336;
                is_moving_automatically = true;
            }
            
            cutscene_step = 3.2; // Go to the new waiting step
        }
        break;

    // --- WAITING STEP FOR MC MOVEMENT ---
    case 3.2:
        if (!instance_exists(obj_MC) || !obj_MC.is_moving_automatically) {
            // Movement is done, continue the dialogue
            cutscene_step = 4;
        }
        break;

    case 4:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "There’s still warm bread. I can slice some, if you want.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_Mother;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 5;
        }
        break;
    
    case 5:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Father";
            current_dialogue = "I think she can manage, hon. But if you want it, it’s there.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_Father;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 6;
        }
        break;

    case 6:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "They’re trying, in their own quiet ways. No pressure. No questions. Just… space. Space that feels a little easier to breathe in tonight.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 7;
        }
        break;

    case 7:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "We’ve been… thinking about things. About how things have felt lately.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_MotherD;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 8;
        }
        break;

    case 8:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Father";
            current_dialogue = "We know we haven’t made it easy here. For you. Or for each other.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_FatherD;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 9;
        }
        break;

    case 9:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "You don’t have to say anything right now. But… if there’s anything on your mind, anything at all, we’re listening.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_MotherD;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 10;
        }
        break;

    case 10:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "It’s quiet again. But not heavy. Just uncertain, like everyone’s waiting to see if someone will dare to be honest first.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 11;
        }
        break;

    case 11: // Player Choice
        if (!choice_made && !choice_active) {
            choice_options = [
                "I don’t know what to say yet… but I hear you.",
                "I’m tired. That’s all.",
                "Can we… maybe not do this right now?"
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
				portrait_sprite = spr_Profile_MC;
                current_dialogue = choice_options[choice_selected];
                global.dialogue_visible = true;

                if (choice_selected == 0) player_mood += 1;
                else if (choice_selected == 1) player_mood -= 2;
                else if (choice_selected == 2) player_mood -= 1;

                global.player_mood = player_mood;
                cutscene_step = 11.5;
            }
        }
        break;

    case 11.5: // Wait after choice
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 12;
        }
        break;

    case 12:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "They both nod, almost at the same time.";
			portrait_sprite = -1;
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 13;
        }
        break;

    case 13:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Mother";
            current_dialogue = "Okay. Whenever you’re ready.";
			portrait_sprite = spr_Profile_Mother;
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 14;
        }
        break;

    case 14:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Father";
            current_dialogue = "We just want you to know you’re not alone. That’s all.";
			portrait_sprite = spr_Profile_Father;
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 15;
        }
        break;

    case 15: // MODIFIED FOR CONDITIONAL ENDING
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
			portrait_sprite = -1;

            // Check the total mood score for Day 2 to determine the ending
            if (global.player_mood >= 3) {
                // "A Quiet Shift" ending
                current_dialogue = "The air in the room feels different. It’s not fixed, but it's softer. You head to your room, the space between you and your parents no longer feeling like a chasm, but a bridge waiting to be built. For the first time, you feel like maybe the next morning won't be a repeat of the last.";
            } else {
                // "Stagnant Air" ending
                current_dialogue = "The quiet returns, heavier this time. You head to your room. The walls that you’ve built over the past few months don’t feel any closer to coming down. You’re all still waiting for something, but no one seems to know what it is. The silence isn't a truce, it's just the status quo.";
            }
            
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 16;
        }
        break;

    case 16:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The next day...";
			portrait_sprite = -1;
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 17;
        }
        break;

    case 17:
        if (!global.dialogue_visible) {
            global.cutscene_active = false; // Set to false to allow player control in the next room
            room_goto(Day_3); // Go to the next scene
            instance_destroy();
        }
        break;
}