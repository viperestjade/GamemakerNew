// Create Event
fade_alpha = 0;          // transparency for fade in/out (0 = invisible, 1 = fully visible)
fade_speed = 0.02;       // how fast to fade
state = "fadein";        // current phase: "fadein", "hold", "fadeout", "done"
hold_time = 2 * room_speed; // how long to display (0.3 seconds → converted to steps)
hold_counter = 0;
