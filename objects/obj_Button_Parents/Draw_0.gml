draw_sprite_ext(
    spr_normal,
    image_index,
    x, y,
    image_xscale, image_yscale,
    image_angle,
    c_white,
    1
);

if (spr_glow != noone) {
    draw_sprite_ext(
        spr_glow,
        image_index,
        x, y,
        image_xscale, image_yscale,
        image_angle,
        c_white,
        glow_alpha
    );
}
