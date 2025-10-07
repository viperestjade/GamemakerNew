if (show_timer > 0 && message != "") {
    var alpha = show_timer / show_duration;

    draw_set_alpha(alpha);
    draw_set_color(c_white);
    draw_set_font(font_location);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    draw_text(display_get_gui_width() / 2, 40, message);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    show_timer--;
}