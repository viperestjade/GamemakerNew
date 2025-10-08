// In obj_controller_hallway -> Step Event

// --- Fade-in, Typewriter, and Skip Logic ---
// (Copy the standard fade/typewriter/skip code here)
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
if (dialogue_stage == 0 && !global.dialogue_visible) {
    dialogue_speaker = "Narration";
    current_dialogue = "Bell rings faintly. Students chatter and shuffle through the school gates. You walk in, bag slung over one shoulder.";
    global.dialogue_visible = true;
	portrait_sprite = -1;
    reset_typewriter();
}
else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 1;
    dialogue_speaker = "Narration";
    current_dialogue = "You don’t really look around much, just head straight in, eyes low.";
	portrait_sprite = -1;
    reset_typewriter();
}
else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 2;
    dialogue_speaker = "Narration";
    current_dialogue = "A few classmates are already hanging out near the canteen, laughing about something that probably isn’t funny unless you were there for the start of the joke.";
    portrait_sprite = -1;
	reset_typewriter();
}
else if (dialogue_stage == 2 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    dialogue_stage = 3;
    dialogue_speaker = "Inner Thought";
    current_dialogue = "Feels like everyone else had a normal morning. I wonder if anyone else had to walk past a war zone just to get here.";
    portrait_sprite = spr_Profile_IT;
	reset_typewriter();
}
else if (dialogue_stage == 3 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
    // End of the hallway scene
    global.dialogue_visible = false;
    global.cutscene_active = false; // Give control back to the player
}