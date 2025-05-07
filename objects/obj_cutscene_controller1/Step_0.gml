// --- Cutscene ID Check (decides which cutscene to run)
switch (global.cutscene_id) {

    case 0: // Cutscene 1: Argument between parents
	    if (fade_alpha > 0) fade_alpha -= 0.02;

	    if (dialogue_visible) {
	        typewriter_counter += 1;
	        if (typewriter_counter >= typewriter_speed) {
	            typewriter_counter = 0;
	            if (typewriter_index < string_length(current_dialogue)) {
	                typewriter_index += 1;
	                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
	            }
	        }
	    } else {
	        typewriter_index = 0;
	        displayed_text = "";
	    }

	    switch (cutscene_step) {
	        case 0:
	            if (dialogue_stage == 0 && !dialogue_visible) {
	                dialogue_speaker = "Mother (muffled)";
	                current_dialogue = "So you’re just going to leave her here with us pretending it’s normal?!";
	                dialogue_visible = true;
	            } 
	            else if (dialogue_stage == 0 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_stage = 1;
	                dialogue_speaker = "Father (muffled)";
	                current_dialogue = "It’s always on me, isn’t it? What about what I want?";
	                typewriter_index = 0;
	                displayed_text = "";
	                typewriter_counter = 0;
	                dialogue_visible = true;
	            }

	            else if (dialogue_stage == 1 && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_stage = 0;
	                dialogue_visible = false;
	                cutscene_step = 1;
	            }
	            break;

	        case 1:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Inner Thought";
	                current_dialogue = "I wish I was somewhere else.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 2;
	            }
	            break;

	        case 2:
	            if (!choice_made && !choice_active) {
	                choice_options = [
	                    "Put on headphones and shut it out",
	                    "Text a friend (no reply)",
	                    "Just sit and listen quietly"
	                ];
	                choice_selected = 0;
	                choice_active = true;
	            }
	            else if (choice_active) {
	                if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	                    choice_made = true;
	                    choice_active = false;

	                    dialogue_speaker = "Inner Thought";
	                    current_dialogue = choice_options[choice_selected];
	                    dialogue_visible = true;

						if (choice_selected == 0) {
							player_mood -= 1;
						} else if (choice_selected == 2) {
							player_mood -= 2;
						}
						global.player_mood = player_mood;


	                    cutscene_step = 3;
	                }
	            }
	            break;

	        case 3:
	            if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 4;
	            }
	            break;

	        case 4:
	            if (!dialogue_visible) {
	                dialogue_speaker = "";
	                current_dialogue = "You leave for school. No one says goodbye.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                global.cutscene_id = 1;
	                global.cutscene_active = true;
	                room_goto(school_cutscene_1);
	            }
	            break;
	    }
	    break;


    case 1: // Cutscene 2: MC walks to school
	    if (fade_alpha > 0) fade_alpha -= 0.02;

	    if (dialogue_visible) {
	        typewriter_counter += 1;
	        if (typewriter_counter >= typewriter_speed) {
	            typewriter_counter = 0;
	            if (typewriter_index < string_length(current_dialogue)) {
	                typewriter_index += 1;
	                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
	            }
	        }
	    } else {
	        typewriter_index = 0;
	        displayed_text = "";
	    }

	    switch (cutscene_step) {
	        case 0:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Inner Thought";
	                current_dialogue = "They don’t know what it's like to feel invisible... or too visible at home.";
	                dialogue_visible = true;
	            }
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 1;
	            }
	            break;

	        case 1:
	            if (!choice_made && !choice_active) {
	                choice_options = [
	                    "Keep head down and walk",
	                    "Glance at them and smile",
	                    "Bump into someone and apologize quickly"
	                ];
	                choice_selected = 0;
	                choice_active = true;
	            }
	            else if (choice_active) {
	                if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	                    choice_made = true;
	                    choice_active = false;

	                    dialogue_speaker = "Inner Thought";
	                    current_dialogue = choice_options[choice_selected];
	                    dialogue_visible = true;

						if (choice_selected == 1 || choice_selected == 2) {
							player_mood += 1;
						}
						global.player_mood = player_mood;

	                    cutscene_step = 2;
	                }
	            }
	            break;

	        case 2:
	            if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 3;
	            }
	            break;

	        case 3:
	            if (!dialogue_visible) {
	                dialogue_speaker = "";
	                current_dialogue = "The day continues as usual.";
	                dialogue_visible = true;
	            }
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                global.cutscene_id = 2;
	                global.cutscene_active = true;
	                room_goto(school_cutscene_2);
	            }
	            break;
	    }
	    break;


    case 2: // Cutscene 3: Class Time - Classroom A
	    if (fade_alpha > 0) fade_alpha -= 0.02;

	    if (dialogue_visible) {
	        typewriter_counter += 1;
	        if (typewriter_counter >= typewriter_speed) {
	            typewriter_counter = 0;
	            if (typewriter_index < string_length(current_dialogue)) {
	                typewriter_index += 1;
	                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
	            }
	        }
	    } else {
	        typewriter_index = 0;
	        displayed_text = "";
	    }

	    switch (cutscene_step) {
	        case 0:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Professor Reyes";
	                current_dialogue = "Okay class, let’s review the themes from yesterday.";
	                dialogue_visible = true;
	            }
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 1;
	            }
	            break;

	        case 1:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Inner Thought";
	                current_dialogue = "I can’t focus. My head’s still back home...";
	                dialogue_visible = true;
	            }
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 2;
	            }
	            break;

	        case 2:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Professor Reyes";
	                current_dialogue = "You seemed out of it. Everything alright?";
	                dialogue_visible = true;
	            }
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 3;
	            }
	            break;

	        case 3:
	            if (!choice_made && !choice_active) {
	                choice_options = [
	                    "Just tired.",
	                    "It’s nothing.",
	                    "Rough morning."
	                ];
	                choice_selected = 0;
	                choice_active = true;
	            }
	            else if (choice_active) {
	                if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	                    choice_made = true;
	                    choice_active = false;

	                    dialogue_speaker = "Inner Thought";
	                    current_dialogue = choice_options[choice_selected];
	                    dialogue_visible = true;

						if (choice_selected == 1) {
						    player_mood -= 1;
						} else if (choice_selected == 2) {
						    player_mood += 2;
						}
						global.player_mood = player_mood;


	                    cutscene_step = 4;
	                }
	            }
	            break;

	        case 4:
	            if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 5;
	            }
	            break;

	        case 5:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Professor Reyes";
	                current_dialogue = "If you ever need to talk, my door’s open. Or visit the counselor’s office. No pressure.";
	                dialogue_visible = true;
	            }
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                global.cutscene_id = 3; // ✅ Update to next cutscene ID
	                global.cutscene_active = true;
	                room_goto(house_cutscene_2); // 🔁 Proceed to next cutscene room
	            }
	            break;
		}
		break;

		
	case 3: // Cutscene 4: Evening — Back Home
	    if (fade_alpha > 0) fade_alpha -= 0.02;

	    if (dialogue_visible) {
	        typewriter_counter += 1;
	        if (typewriter_counter >= typewriter_speed) {
	            typewriter_counter = 0;
	            if (typewriter_index < string_length(current_dialogue)) {
	                typewriter_index += 1;
	                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
	            }
	        }
	    } else {
	        typewriter_index = 0;
	        displayed_text = "";
	    }

	    switch (cutscene_step) {
	        case 0:
	            if (!dialogue_visible) {
	                dialogue_speaker = "";
	                current_dialogue = "Dinner is quiet. Only Mom is present. The TV plays in the background.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 1;
	            }
	            break;

	        case 1:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Mom";
	                current_dialogue = "He’ll be staying at your aunt’s for now.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 2;
	            }
	            break;

	        case 2:
	            if (!choice_made && !choice_active) {
	                choice_options = [
	                    "Is he coming back?",
	                    "I don’t care.",
	                    "..."
	                ];
	                choice_selected = 0;
	                choice_active = true;
	            }
	            else if (choice_active) {
	                if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	                    choice_made = true;
	                    choice_active = false;

	                    dialogue_speaker = "Inner Thought";
	                    current_dialogue = choice_options[choice_selected];
	                    dialogue_visible = true;

						if (choice_selected == 0) {
						    player_mood += 1;
						} else if (choice_selected == 1) {
						    player_mood -= 2;
						}
						global.player_mood = player_mood;

	                    cutscene_step = 3;
	                }
	            }
	            break;

	        case 3:
	            if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 4;
	            }
	            break;

	        case 4:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Inner Thought";
	                current_dialogue = "So this is how it begins... or ends.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
					global.cutscene_id = 4;
	                global.cutscene_active = true;
	                room_goto(house_day2_cutscene_1); // Replace 'next_scene' with the appropriate next room or scene
	            }
	            break;
	    }
	    break;
		
		case 4: // Cutscene 5: Morning - Kitchen
	    if (fade_alpha > 0) fade_alpha -= 0.02;

	    if (dialogue_visible) {
	        typewriter_counter += 1;
	        if (typewriter_counter >= typewriter_speed) {
	            typewriter_counter = 0;
	            if (typewriter_index < string_length(current_dialogue)) {
	                typewriter_index += 1;
	                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
	            }
	        }
	    } else {
	        typewriter_index = 0;
	        displayed_text = "";
	    }

	    switch (cutscene_step) {
	        case 0:
	            if (!dialogue_visible) {
	                dialogue_speaker = "";
	                current_dialogue = "Mom is up early, looking at her phone. Eyes look tired.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 1;
	            }
	            break;

	        case 1:
	            if (!dialogue_visible) {
	                dialogue_speaker = "";
	                current_dialogue = "She glances at MC";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 2;
	            }
	            break;
				
			case 2:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Mom";
	                current_dialogue = "Don’t skip breakfast. I made coffee.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 3;
	            }
	            break;

	        case 3:
	            if (!choice_made && !choice_active) {
	                choice_options = [
	                    "Sit and eat silently",
	                    "You okay?",
	                    "Ignore and leave"
	                ];
	                choice_selected = 0;
	                choice_active = true;
	            }
	            else if (choice_active) {
	                if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	                    choice_made = true;
	                    choice_active = false;

	                    dialogue_speaker = "Inner Thought";
	                    current_dialogue = choice_options[choice_selected];
	                    dialogue_visible = true;

						if (choice_selected == 1) {
						    player_mood += 2;
						} else if (choice_selected == 2) {
						    player_mood -= 2;
						}
						global.player_mood = player_mood;

	                    cutscene_step = 4;
	                }
	            }
	            break;

	        case 4:
	            if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
					global.cutscene_id = 5;
	                global.cutscene_active = true;
	                room_goto(school_day2_cutscene_1); // Replace 'next_scene' with the appropriate next room or scene
	            }
	            break;
	    }
	    break;	
		
		case 5: // Cutscene 6: Hallway + Class — Classroom B
	    if (fade_alpha > 0) fade_alpha -= 0.02;

	    if (dialogue_visible) {
	        typewriter_counter += 1;
	        if (typewriter_counter >= typewriter_speed) {
	            typewriter_counter = 0;
	            if (typewriter_index < string_length(current_dialogue)) {
	                typewriter_index += 1;
	                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
	            }
	        }
	    } else {
	        typewriter_index = 0;
	        displayed_text = "";
	    }

	    switch (cutscene_step) {
	        case 0:
	            if (!dialogue_visible) {
	                dialogue_speaker = "";
	                current_dialogue = "Students are discussing weekend plans.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 1;
	            }
	            break;

	        case 1:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Student";
	                current_dialogue = "My parents won’t let me go out ugh!";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 2;
	            }
	            break;
				
			case 2:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Student";
	                current_dialogue = "You’re lucky your parents don’t care.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 3;
	            }
	            break;
				
			case 3:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Inner Thought";
	                current_dialogue = "I’d trade anything just for that normal chaos.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 4;
	            }
	            break;

	        case 4:
	            if (!dialogue_visible) {
	                dialogue_speaker = "";
	                current_dialogue = "Class begins. MC zones out again.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 5;
	            }
	            break;
			
			case 5:
	            if (!dialogue_visible) {
	                dialogue_speaker = "Ms. Reyes";
	                current_dialogue = "You still seem heavy. You know the counselor’s name is Ms. Liza — she’s good with these things.";
	                dialogue_visible = true;
	            } 
	            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
	                cutscene_step = 6;
	            }
	            break;
				
			case 6:
	            if (!dialogue_visible) {
			        dialogue_speaker = "Inner Thought";
			        current_dialogue = "Maybe it’s worth a try...";
			        dialogue_visible = true;
			    } 
			   else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
	                dialogue_visible = false;
					global.cutscene_id = 6;
	                global.cutscene_active = true;
	                room_goto(counselor_office_day2_cutscene_1); // Replace 'next_scene' with the appropriate next room or scene
	            }
	            break;	
			}
			break;
			
			case 6: // Cutscene 7: Counselor Office
		    if (fade_alpha > 0) fade_alpha -= 0.02;

		    if (dialogue_visible) {
		        typewriter_counter += 1;
		        if (typewriter_counter >= typewriter_speed) {
		            typewriter_counter = 0;
		            if (typewriter_index < string_length(current_dialogue)) {
		                typewriter_index += 1;
		                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
		            }
		        }
		    } else {
		        typewriter_index = 0;
		        displayed_text = "";
		    }

		    switch (cutscene_step) {
		        case 0:
		            if (!dialogue_visible) {
		                dialogue_speaker = "";
		                current_dialogue = "Warm light. Calm music. Ms. Liza smiles kindly";
		                dialogue_visible = true;
		            } 
		            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
		                dialogue_visible = false;
		                cutscene_step = 1;
		            }
		            break;

		        case 1:
		            if (!choice_made && !choice_active) {
			        choice_options = [
			            "My parents are splitting up.",
			            "I’m scared I’m breaking too.",
			            "I just want it to stop."
			        ];
			        choice_selected = 0;
			        choice_active = true;
			    }
			    else if (choice_active) {
			        if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
			        if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
			        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
			            choice_made = true;
			            choice_active = false;

			            dialogue_speaker = "Inner Thought";
			            current_dialogue = choice_options[choice_selected];
			            dialogue_visible = true;

			            // Update mood based on selected choice
			            if (choice_selected == 0) {
			                player_mood += 2;
			            } else if (choice_selected == 1) {
			                player_mood += 1;
			            } else if (choice_selected == 2) {
			                player_mood -= 1;
			            }
			            global.player_mood = player_mood;
			        }
			    }
			    else if (choice_made && keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
			        dialogue_visible = false;
			        cutscene_step = 2;
			    }
			    break;
				
				case 2:
		            if (!dialogue_visible && typewriter_index == 0) {
				        dialogue_speaker = "Counselor";
				        current_dialogue = "It’s okay to want peace, but also okay to feel everything first.";
				        dialogue_visible = true;
				    } 
				    else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
		                dialogue_visible = false;
						global.cutscene_id = 7;
		                global.cutscene_active = true;
		                room_goto(house_day2_cutscene_3); // Replace 'next_scene' with the appropriate next room or scene
		            }
		            break;	
		}
		break;
		
		case 7: // Cutscene 8: Evening - Living Room
		    if (fade_alpha > 0) fade_alpha -= 0.02;

		    if (dialogue_visible) {
		        typewriter_counter += 1;
		        if (typewriter_counter >= typewriter_speed) {
		            typewriter_counter = 0;
		            if (typewriter_index < string_length(current_dialogue)) {
		                typewriter_index += 1;
		                displayed_text = string_copy(current_dialogue, 1, typewriter_index);
		            }
		        }
		    } else {
		        typewriter_index = 0;
		        displayed_text = "";
		    }

		    switch (cutscene_step) {
		        case 0:
		            if (!dialogue_visible) {
		                dialogue_speaker = "Mom";
		                current_dialogue = "We’re... not doing okay. But I don’t want that pain to be your whole story.";
		                dialogue_visible = true;
		            } 
		            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
		                dialogue_visible = false;
		                cutscene_step = 1;
		            }
		            break;

		        case 1:
		            if (!choice_made && !choice_active) {
	                choice_options = [
	                    "I want to talk to Dad.",
	                    "This still sucks.",
	                    "You should’ve fixed it before."
	                ];
	                choice_selected = 0;
	                choice_active = true;
	            }
	            else if (choice_active) {
	                if (keyboard_check_pressed(vk_down)) choice_selected = (choice_selected + 1) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_up)) choice_selected = (choice_selected - 1 + array_length(choice_options)) % array_length(choice_options);
	                if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	                    choice_made = true;
	                    choice_active = false;

	                    dialogue_speaker = "Inner Thought";
	                    current_dialogue = choice_options[choice_selected];
	                    dialogue_visible = true;

						if (choice_selected == 0) {
						    player_mood += 2;
						} else if (choice_selected == 1) {
						    player_mood += 1;
						} else if (choice_selected == 2) {
						    player_mood -= 2;
						}
						global.player_mood = player_mood;

	                    cutscene_step = 2;
	                }
	            }
	            break;
				
		        case 4:
					if (!dialogue_visible) {
		                dialogue_speaker = "";
		                current_dialogue = "";
		                dialogue_visible = true;
		            } 
		            else if (keyboard_check_pressed(vk_space) && typewriter_index >= string_length(current_dialogue)) {
		                dialogue_visible = false;						
		                global.cutscene_active = false;
		                room_goto(house_day3_cutscene_1); // Replace 'next_scene' with the appropriate next room or scene
		            }
		            break;	
		}
		break;
}
