// In obj_interactive_door -> Draw Event

// This line makes sure the object's own sprite is drawn.
draw_self();

// If the player is close enough to interact...
if (player_is_close) {

    // Set the font and alignment for our text prompt.
    // Replace 'fnt_prompt' with your own font or remove the line.
    // draw_set_font(fnt_game); 
    draw_set_halign(fa_center); // Center the text horizontally
    draw_set_valign(fa_bottom);  // Draw from the bottom up

    // Draw the prompt text slightly above the door's position.
    // You can change 'y - 40' to adjust the height.
    draw_text(x, y - 40, prompt_text);
}