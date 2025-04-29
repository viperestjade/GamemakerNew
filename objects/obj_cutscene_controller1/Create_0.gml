// CREATE
// --- Cutscene variables
cutscene_step = 0;
cutscene_timer = 0;
global.cutscene_active = true;

// --- Fade variables
fade_alpha = 1;

// --- Dialogue variables
dialogue_visible = false;
dialogue_speaker = "";
current_dialogue = "";

// --- Typewriter effect
typewriter_speed = 2; // frames per letter
typewriter_counter = 0;
typewriter_index = 0;
displayed_text = "";

// --- Choice variables
choice_active = false;
choice_options = [];
choice_selected = 0;
choice_made = false;
choice_result = -1;

// --- Player mood (example stat)
player_mood = 0;

// --- Internal helper
dialogue_stage = 0; // new variable to track inside a step
