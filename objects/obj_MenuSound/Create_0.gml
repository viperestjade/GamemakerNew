if (!variable_global_exists("menu_music") || !audio_is_playing(global.menu_music)) {
    global.menu_music = audio_play_sound(snd_menu_music, true, 1);
}
