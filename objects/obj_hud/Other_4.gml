switch (room) {
    case room_Day1_Scene1:
        message = "Bedroom";
        break;
		
	case room_Day1_Scene2:
        message = "Living Room";
        break;
		
	case room_Day1_Scene3:
        message = "School Hallway";
        break;
		
	case room_Day1_Scene4:
        message = "Classroom";
        break;
		
	case room_Day1_Scene5:
        message = "Kitchen";
        break;
		
	case room_Day2_Scene1:
        message = "Bedroom";
        break;
		
	case room_Day2_Scene2:
        message = "Kitchen";
        break;
		
	case room_Day2_Scene3:
        message = "Classroom";
        break;
		
	case room_Day2_Scene4:
        message = "School Hallway";
        break;
		
	case room_Day2_Scene5:
        message = "Living Room";
        break;
		
	case room_Day2_Scene6:
        message = "Kitchen";
        break;
		
	case room_Day3_Scene1:
        message = "Bedroom";
        break;
		
	case room_Day3_Scene2:
        message = "Kitchen";
        break;
		
	case room_Day3_Scene2_1:
        message = "Living Room";
        break;
		
	case room_Day3_Scene3:
        message = "School Hallway";
        break;
		
	case room_Day3_Scene4:
        message = "Classroom";
        break;
		
	case room_Day3_Scene5:
        message = "Counselor's Office";
        break;
		
	case room_Day3_Scene6:
        message = "Living Room";
        break;
	
	default:
        message = "";
        break;
}

show_timer = (message != "") ? show_duration : 0;

if (message != "") {
    show_timer = show_duration;
}