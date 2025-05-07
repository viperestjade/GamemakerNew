// DRAW GUI
// --- Fade from black
if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

// --- Draw dialogue normally (top-left)
if (dialogue_visible) {
    if (dialogue_speaker != "") {
        draw_set_color(c_white);
        draw_text(50, 620, dialogue_speaker + ":");
    }

    draw_set_color(c_white);
    draw_text(50, 650, displayed_text);

    if (typewriter_index >= string_length(current_dialogue)) {
        draw_set_color(c_white);
        draw_text(display_get_gui_width() - 150, display_get_gui_height() - 30, "[Press SPACE]");
    }
}

// --- Draw choices clearly
if (choice_active) {
    var base_x = 50;
    var base_y = 640;
    var spacing = 40;

    for (var i = 0; i < array_length(choice_options); i++) {
        if (i == choice_selected) {
            // Draw highlighted background box
            draw_set_color(c_dkgray);
            draw_rectangle(base_x - 10, base_y + (i * spacing) - 5, base_x + 400, base_y + (i * spacing) + 30, false);
            draw_set_color(c_white);
            draw_text(base_x, base_y + (i * spacing), choice_options[i]);
        } else {
            draw_set_color(c_gray);
            draw_text(base_x, base_y + (i * spacing), choice_options[i]);
        }
    }
}

// --- DEBUG: Show player mood
draw_set_color(c_white);
draw_text(20, 20, "Mood: " + string(player_mood));