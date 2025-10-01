var txt = "DAY 3: \"Morning Light\"";

draw_set_font(-1); // use built-in default font
draw_set_color(c_white);
draw_set_alpha(fade_alpha);

var w = display_get_gui_width();
var h = display_get_gui_height();

// Scale factor (bigger number = bigger text)
var scale = 2; 

// Center text using transformed width/height
var text_w = string_width(txt) * scale;
var text_h = string_height(txt) * scale;

draw_text_transformed(w/2 - text_w/2, h/2 - text_h/2, txt, scale, scale, 0);

draw_set_alpha(1); // reset alpha
