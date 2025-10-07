// Step Event of obj_Day1_Summary

// Check if player presses E while holding
if (keyboard_check_pressed(ord("E")) && state == "hold") {
    state = "fadeout";
}

// Handle fade states
switch (state) {
    case "fadein":
        alpha += fade_speed;
        if (alpha >= 1) {
            alpha = 1;
            state = "hold"; // wait for player input
        }
        break;

    case "hold":
        // Wait until player presses E
        break;

    case "fadeout":
        alpha -= fade_speed;
        if (alpha <= 0) {
            alpha = 0;
            state = "done";
            room_goto(room_Day3_Scene1); // <-- change to your actual next room
        }
        break;
}
