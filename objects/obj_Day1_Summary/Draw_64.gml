/// Draw GUI Event of obj_Day1_Summary
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Summary text
var summary_text = 
"DAY 1 Summary:\n\n" +
"The day starts with the loud sound of your parents fighting, what feels like a war zone.\n\n" + 
"You leave for school trying to be as quiet as possible.\n\n" +
"At school, you have to talk about stress with a classmate named Casey.\n\n" +
"This simple talk gives you a short, surprising moment of feeling understood.\n\n" +
"You come home to a quiet, but heavy, kitchen. Your mother tries to connect with you while you eat soup.\n\n" + 
"You can choose to talk about the stress or stay quiet.\n\n" +
"Your choices today shape the feeling you take into the next morning.";

// Draw summary text (scaled bigger)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(alpha);
draw_text_ext_transformed(gui_w/2, gui_h/2 - 50, summary_text, 40, gui_w - 100, 1.3, 1.3, 0);

// Draw "Press E to proceed" at bottom (medium size)
var proceed_text = "Press E to proceed";
draw_set_alpha(alpha);
draw_text_transformed(gui_w/2, gui_h - 100, proceed_text, 1.0, 1.0, 0);
