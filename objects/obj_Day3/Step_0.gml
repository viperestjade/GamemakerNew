// Step Event
switch (state) {
    case "fadein":
        fade_alpha += fade_speed;
        if (fade_alpha >= 1) {
            fade_alpha = 1;
            state = "hold";
        }
        break;

    case "hold":
        hold_counter++;
        if (hold_counter >= hold_time) {
            state = "fadeout";
        }
        break;

    case "fadeout":
        fade_alpha -= fade_speed;
        if (fade_alpha <= 0) {
            fade_alpha = 0;
            state = "done";
            room_goto(room_Day3_Scene1); // go to the next room
        }
        break;
}
