// This code manages the first part of the scene in the bedroom.

// --- Fade-in, Typewriter, and Skip Logic ---
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
    } else {
        displayed_text = current_dialogue;
    }
} else {
    typewriter_index = 0;
    displayed_text = "";
    typewriter_counter = 0;
}

// Logic to skip the typewriter effect to the end of the line
if (global.dialogue_visible && keyboard_check_pressed(vk_space) && typewriter_index < string_length(current_dialogue)) {
    typewriter_index = string_length(current_dialogue);
    displayed_text = current_dialogue;
    exit;
}

// --- Bedroom Dialogue Progression ---
switch (cutscene_step) {
    case 0:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "The sun barely slips through the curtains. The room feels colder today, like the quiet before a storm, only there’s no yelling this time.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 1;
        }
        break;

    case 1:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Inner Thought";
            current_dialogue = "Maybe today won’t be like the others.";
            global.dialogue_visible = true;
			portrait_sprite = spr_Profile_IT;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            global.dialogue_visible = false;
            cutscene_step = 2;
        }
        break;

    case 2:
        if (!global.dialogue_visible) {
            dialogue_speaker = "Narration";
            current_dialogue = "You slip out of bed, tugging on your clothes mechanically, as if you’ve done this too many times to care. Your bag feels heavier than usual, and your thoughts, they’re just as scattered.";
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
            current_dialogue = "The sound of clattering dishes drifts to your room. It’s only your mom. She must be making breakfast, but there’s no noise beyond that. No shuffling, no small talk. Just the faint, rhythmic sound of someone trying not to be noticed.";
            global.dialogue_visible = true;
			portrait_sprite = -1;
        }
        else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
            // --- END OF BEDROOM CUTSCENE ---
            
            // Hide the dialogue box before ending. This is the crucial fix.
            global.dialogue_visible = false;
            
            // Set a global flag to indicate this part is done for the door object.
            global.bedroom_dialogue_complete = true;
            
            // Give control back to the player.
            global.cutscene_active = false;
            
            // This cutscene controller's job is done.
            instance_destroy();
        }
        break;
}