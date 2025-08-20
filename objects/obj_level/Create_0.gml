if (!variable_global_exists("level")) {
    global.level = 1;
}


switch (global.level) {
    case 1: global.pairs = 3; break;  // 6 cards
    case 2: global.pairs = 6; break;  // 12 cards
    case 3: global.pairs = 10; break; // 20 cards
    default: global.pairs = 3; break;
}

var total_cards = global.pairs * 2;

randomize();
deck = ds_list_create();


var sprite_pool = ds_list_create();
ds_list_add(sprite_pool,
    spr_Bread, spr_Cookie, spr_Pretzel, spr_Apple, spr_Bacon,
    spr_Brick, spr_Cheese, spr_Egg, spr_Potato, spr_Watermelon
);


if (ds_list_size(sprite_pool) < global.pairs) {
    show_message("Not enough unique sprites for " + string(global.pairs) + " pairs!");
}


ds_list_shuffle(sprite_pool);
for (var i = 0; i < global.pairs; i++) {
    var spr = sprite_pool[| i];
    ds_list_add(deck, spr, spr);
}
ds_list_destroy(sprite_pool);


ds_list_shuffle(deck);


var card_w = sprite_get_width(spr_back_med);
var card_h = sprite_get_height(spr_back_med);
var spacing = 10;

var cols = ceil(sqrt(total_cards));
var rows = ceil(total_cards / cols);


var grid_w = cols * card_w + (cols - 1) * spacing;
var grid_h = rows * card_h + (rows - 1) * spacing;
var offset_x = (room_width  - grid_w) div 2;
var offset_y = (room_height - grid_h) div 2;


for (var i = 0; i < total_cards; i++) {
    var cx = i mod cols;
    var cy = i div cols;

    var card = instance_create_layer(
        offset_x + cx * (card_w + spacing),
        offset_y + cy * (card_h + spacing),
        "Instances",
        obj_card
    );

    card.sprite_index = deck[| i];
    card.flipped = false;
}

global.selected = ds_list_create();
