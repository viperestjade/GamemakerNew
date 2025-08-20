// DRAW GUI

// --- Fade from black
if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

// --- Setup GUI dimensions
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var margin = 40;
var text_x = margin;
var text_y = gui_h - 160;
var text_w = gui_w - (margin * 2);
var line_spacing = 5;
var dialogue_height = 100;

// --- Draw dialogue box
if (dialogue_visible) {
    // Draw semi-transparent background box
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(text_x - 10, text_y - 30, text_x + text_w + 10, text_y + dialogue_height, false);
    draw_set_alpha(1);

    // Draw speaker name
    if (dialogue_speaker != "") {
        draw_set_color(c_yellow);
        draw_text(text_x, text_y - 25, dialogue_speaker + ":");
    }

    // Draw wrapped dialogue text
    draw_set_color(c_white);
    var display_string = string_copy(current_dialogue, 1, typewriter_index);
    draw_text_ext(text_x, text_y, display_string, -1, text_w);

    // Prompt if finished typing
    if (typewriter_index >= string_length(current_dialogue)) {
        draw_set_color(c_gray);
        draw_text(gui_w - 170, gui_h - 50, "[Press SPACE]");
    }
}

// --- Draw choices clearly
if (choice_active) {
    var base_x = margin;
    var base_y = text_y + dialogue_height - 120;
    var spacing = 40;

    for (var i = 0; i < array_length(choice_options); i++) {
        var choice_y = base_y + (i * spacing);

        var text = choice_options[i];
        var text_width = string_width(text);
        var text_height = string_height(text);

        var padding_x = 10;
        var padding_y = 5;
        var box_left = base_x - padding_x;
        var box_top = choice_y - padding_y;
        var box_right = base_x + text_width + padding_x;
        var box_bottom = choice_y + text_height + padding_y;

        if (i == choice_selected) {
            draw_set_color(c_dkgray);
            draw_rectangle(box_left, box_top, box_right, box_bottom, false);
        }

        draw_set_color(i == choice_selected ? c_white : c_gray);
        draw_text(base_x, choice_y, text);
    }
}

if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

