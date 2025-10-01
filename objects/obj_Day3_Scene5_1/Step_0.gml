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

// --- Scene Progression (Re-numbered to start from 0) ---
switch (cutscene_step) {
    case 0: // Formerly case 2
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "Don’t worry about saying everything perfectly. We just talk here. Or not talk. Whatever you need.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1: // Formerly case 3
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You nod, your hands resting between your knees.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            choice_made = false;
            cutscene_step = 2;
        }
        break;

    case 2: // Formerly case 4
        if (!choice_made && !choice_active) {
            choice_options = [
                "I’ve just been really tired. Not just sleep-tired.",
                "I don’t really know why I’m here.",
                "I’m fine. I just… wanted to see."
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

                if (choice_selected == 0) player_mood += 2;
                else if (choice_selected == 1) player_mood += 1;
                else if (choice_selected == 2) player_mood -= 1;
                global.player_mood = player_mood;
                cutscene_step = 2.5;
            }
        }
        break;

    case 2.5: // Formerly case 4.5
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 3;
        }
        break;

    case 3: // Formerly case 5
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "That’s okay. However we start, it’s still a beginning.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 4;
        }
        break;

    case 4: // Formerly case 6
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "Do you want to tell me a bit about what’s been heavy lately? School? Home? Yourself?";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 5;
        }
        break;
        
    case 5: // Formerly case 7
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You breathe in. Your fingers tap your knee once, twice.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            choice_made = false;
            cutscene_step = 6;
        }
        break;
        
    case 6: // Formerly case 8
        if (!choice_made && !choice_active) {
            choice_options = [
                "It’s just… I feel like I’m slipping behind everyone. Like I’m the only one stuck.",
                "There’s this girl, Casey, she noticed I wasn’t okay. And it kind of scared me.",
                "It’s tense at home. Like, we’re all avoiding something but no one wants to say it."
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
                else if (choice_selected == 1) player_mood += 1;
                else if (choice_selected == 2) player_mood += 2;
                global.player_mood = player_mood;
                cutscene_step = 6.5;
            }
        }
        break;

    case 6.5: // Formerly case 8.5
        if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 7;
        }
        break;
        
    case 7: // Formerly case 9
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "Sounds like you’re carrying a lot. And it’s starting to weigh more now that you’ve noticed it, right?";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 8;
        }
        break;
        
    case 8: // Formerly case 10
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You nod. More certain now than when you walked in. They don’t rush you. Don’t try to patch you up like a broken pipe. They just… listen.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 9;
        }
        break;
        
    case 9: // Formerly case 11
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "You’ve been carrying this mostly on your own, haven’t you? (You nod slightly.)";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 10;
        }
        break;
        
    case 10: // Formerly case 12
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "I’m really glad you opened up here. But I wonder… have you ever tried talking to your parents about any of this?";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 11;
        }
        break;
        
    case 11: // Formerly case 13
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "Not really. It’s… complicated. They’re always so wrapped up in their own mess, I don’t even know where I’d start.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 12;
        }
        break;
        
    case 12: // Formerly case 14
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "I get that. And I’m not saying it’ll be easy, or perfect. But you matter to them. Sometimes they just need to hear it from you. Not just the silence between you all.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 13;
        }
        break;
        
    case 13: // Formerly case 15
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "What if it just makes things worse?";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 14;
        }
        break;
        
    case 14: // Formerly case 16
        if (!global.dialogue_visible) {
            dialogue_speaker = "Counselor";
            current_dialogue = "It might feel messy at first. But honesty has a way of planting seeds. Even if they take time to grow. You don’t have to do it alone, either. I can help you figure out how to start, if you want.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 15;
        }
        break;
        
    case 15: // Formerly case 17
        if (!global.dialogue_visible) {
            dialogue_speaker = "You";
            current_dialogue = "…Okay. Maybe. I’ll try tonight.";
            global.dialogue_visible = true;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 16;
        }
        break;
        
    case 16: // Formerly case 18
        if (!global.dialogue_visible) {
            global.cutscene_active = true;
            room_goto(room_Day3_Scene6); // move to next room/scene
            instance_destroy();
        }
        break;
}