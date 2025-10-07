/// Draw GUI Event of obj_Day1_Summary
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Summary text
var summary_text = 
"DAY 2 Summary:\n\n" +
"Day 2 starts with a muted morning; the fighting has stopped, but the house is strained.\n\n" + 
"Your mother offers breakfast in a quiet attempt to connect.\n\n" +
"At school, your silence is noticed by your teacher and your classmate Casey, who reaches out with a genuine offer of support.\n\n" +
"You arrive home to find both parents making quiet efforts.\n\n" +
"They open a space for you, admitting things have been hard and saying they are listening.\n\n" + 
"The day ends with a noticeable softening of the tension.\n\n" +
"Your choices today determine if this shift leads to a \"Quiet Shift\" or leaves the air \"Stagnant.\"";

// Draw summary text (scaled bigger)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(alpha);
draw_text_ext_transformed(gui_w/2, gui_h/2 - 50, summary_text, 40, gui_w - 100, 1.3, 1.3, 0);

// Draw "Press E to proceed" at bottom (medium size)
var proceed_text = "Press E to proceed";
draw_set_alpha(alpha);
draw_text_transformed(gui_w/2, gui_h - 100, proceed_text, 1.0, 1.0, 0);
