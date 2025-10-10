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
var text_x = margin + 150; // Shift text to the right to make space for portrait
var text_y = gui_h - 160;
var text_w = gui_w - (margin * 2) - 150; // Reduce width so it doesn't overlap
var dialogue_height = 100;

// =================================================================
// --- Dialogue Box Drawing ---
// =================================================================
if (global.dialogue_visible) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // Draw semi-transparent background box
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(text_x - 10, text_y - 30, text_x + text_w + 10, text_y + dialogue_height, false);
    draw_set_alpha(1);

    // ✅ Draw portrait only if there's a valid sprite
    if (portrait_sprite != -1) {
        var portrait_x = margin;
        var portrait_y = text_y - 50;
        var portrait_size = 140;

        var spr_w = sprite_get_width(portrait_sprite);
        var spr_h = sprite_get_height(portrait_sprite);

        draw_sprite_ext(
            portrait_sprite,
            0,
            portrait_x,
            portrait_y,
            portrait_size / spr_w,
            portrait_size / spr_h,
            0,
            c_white,
            1
        );
    }

    // Draw speaker name
    if (dialogue_speaker != "") {
        draw_set_color(c_yellow);
        draw_text(text_x, text_y - 25, dialogue_speaker + ":");
    }

    // Draw wrapped dialogue text
    draw_set_color(c_white);
    draw_text_ext(text_x, text_y, displayed_text, -1, text_w);

    // Prompt to continue when typing is finished
    if (typewriter_index >= string_length(current_dialogue)) {
        draw_set_color(c_gray);
        draw_text(gui_w - 170, gui_h - 50, "[Press SPACE]");
    }
}

// =================================================================
// --- Draw Choices (Bottom-Center Position) ---
// =================================================================
if (choice_active) {
    var box_width = 500;
    var option_count = array_length(choice_options);
    var line_height = 40;
    var box_padding = 20;
    var box_height = (option_count * line_height) + (box_padding * 2);

    var bottom_margin = 40;
    var box_x = (gui_w / 2) - (box_width / 2);
    var box_y = gui_h - box_height - bottom_margin;
    
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
    draw_set_alpha(1);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    
    for (var i = 0; i < option_count; i++) {
        var option_text = choice_options[i];
        var text_x_pos = gui_w / 2;
        var text_y_pos = box_y + box_padding + (i * line_height);
        
        if (i == choice_selected) {
            option_text = "> " + option_text + " <";
            draw_set_color(c_white);
        } else {
            draw_set_color(c_gray);
        }
        
        draw_text(text_x_pos, text_y_pos, option_text);
    }
}
