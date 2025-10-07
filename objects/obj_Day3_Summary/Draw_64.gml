/// Draw GUI Event of obj_Day1_Summary
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Summary text
var summary_text = 
"DAY 3 Summary:\n\n" +
"Day 3 finally brings a quiet morning, a welcome change from the heavy tension of the days before.\n\n" + 
"At school, your classmate Casey notices the improvement and offers genuine support.\n\n" +
"This push helps you accept an invitation to the Counselor's Office later that afternoon.\n\n" +
"There, you feel comfortable enough to share the deep fatigue and stress you have been carrying. \n\n" +
"The counselor encourages you to break the silence with your parents.\n\n" + 
"n the evening, you return home and tell them you \"stayed behind to talk to someone.\" \n\n" +
"This act of honesty opens the door to a much-needed, difficult conversation with your family.";

// Draw summary text (scaled bigger)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(alpha);
draw_text_ext_transformed(gui_w/2, gui_h/2 - 50, summary_text, 40, gui_w - 100, 1.3, 1.3, 0);

// Draw "Press E to proceed" at bottom (medium size)
var proceed_text = "Press E to proceed";
draw_set_alpha(alpha);
draw_text_transformed(gui_w/2, gui_h - 100, proceed_text, 1.0, 1.0, 0);
