// In obj_controller_scene0 -> Step Event

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
            // The audio playing lines and their containing if statement have been removed from here.
        }
    }
    displayed_text = string_copy(current_dialogue, 1, typewriter_index);
} else {
    typewriter_index = 0;
    displayed_text = "";
    typewriter_counter = 0;
}

// --- Dialogue Progression ---
if (dialogue_stage == 0 && !global.dialogue_visible) {
    dialogue_speaker = "Narration";
    current_dialogue = "Distant shouting can be heard from the living room. The air feels heavy.";
	portrait_sprite = -1;
    global.dialogue_visible = true;
}
else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 1;
    dialogue_speaker = "Mother";
    current_dialogue = "You promised you'd be home for dinner last night. Our daughter waited up again!";
	portrait_sprite = spr_Profile_MotherA;
    reset_typewriter();
}
else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 2;
    dialogue_speaker = "Father";
    current_dialogue = "I have deadlines. You think I want to work this much? I’m doing this for us.";
	portrait_sprite = spr_Profile_FatherAT;
    reset_typewriter();
}
else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 3;
    dialogue_speaker = "Mother";
    current_dialogue = "For us? We haven’t had a real conversation in months. You barely know what’s happening in this house.";
    portrait_sprite = spr_Profile_MotherAT;
	reset_typewriter();
}
else if (dialogue_stage == 3 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 4;
    dialogue_speaker = "Father";
    current_dialogue = "Because every time I walk through the door, it’s like I’m walking into a war zone!";
    portrait_sprite = spr_Profile_FatherAT;
	reset_typewriter();
}
else if (dialogue_stage == 4 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 5;
    dialogue_speaker = "Inner Thought";
    current_dialogue = "They’re at it again. Always before school, like a broken alarm clock that only knows how to shout.";
    portrait_sprite = spr_Profile_IT;
	reset_typewriter();
}
else if (dialogue_stage == 5 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 6;
    dialogue_speaker = "Mother";
    current_dialogue = "She’s slipping. I see it. She hardly eats. She’s falling behind. She doesn’t talk to me anymore.";
    portrait_sprite = spr_Profile_MotherAT;
	reset_typewriter();
}
else if (dialogue_stage == 6 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 7;
    dialogue_speaker = "Father";
    current_dialogue = "Because she doesn’t talk to me either! I come home and she’s either asleep or staring at her phone like a stranger.";
	portrait_sprite = spr_Profile_FatherAT;
	reset_typewriter();
}
else if (dialogue_stage == 7 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 8;
    dialogue_speaker = "Mother";
    current_dialogue = "She’s not a machine you just plug in and expect to perform. She needs us. Not just your paycheck. You.";
    portrait_sprite = spr_Profile_MotherAT;
	reset_typewriter();
}
else if (dialogue_stage == 8 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 9;
    dialogue_speaker = "Father";
    current_dialogue = "You think I don’t feel guilty? I’m trying. But everything I do feels like it’s never enough... for either of you.";
    portrait_sprite = spr_Profile_FatherAT;
	reset_typewriter();
}
else if (dialogue_stage == 9 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 10;
    dialogue_speaker = "Inner Thought";
    current_dialogue = "They always forget I can hear everything. Maybe they think I’m still asleep.";
    portrait_sprite = spr_Profile_IT;
	reset_typewriter();
}
else if (dialogue_stage == 10 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    global.dialogue_visible = false;
    global.cutscene_active = false;
	instance_destroy();    
}