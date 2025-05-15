// Inherit the parent event
event_inherited();

if (audio_is_playing(global.menu_music)) {
    audio_stop_sound(global.menu_music);
}

global.cutscene_id = 0;
global.cutscene_active = true;
room_goto(house_day1_scene1);