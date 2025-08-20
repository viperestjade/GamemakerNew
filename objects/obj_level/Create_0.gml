// set random seed
randomize();

// create a list for the deck
deck = ds_list_create();

// add 3 pairs (6 cards total)
ds_list_add(deck, spr_Bread, spr_Bread);
ds_list_add(deck, spr_Cookie, spr_Cookie);
ds_list_add(deck, spr_Pretzel, spr_Pretzel);

// shuffle the deck
ds_list_shuffle(deck);


var card_w = sprite_get_width(spr_back_med); 
var card_h = sprite_get_height(spr_back_med);
var spacing = 10;

var total_cards = ds_list_size(deck);

var cols = ceil(sqrt(total_cards));
var rows = ceil(total_cards / cols);

var grid_w = cols * card_w + (cols - 1) * spacing;
var grid_h = rows * card_h + (rows - 1) * spacing;

var start_x = (room_width - grid_w) div 2;
var start_y = (room_height - grid_h) div 2;

for (var i = 0; i < total_cards; i++)
{
    var col = i mod cols;
    var row = i div cols;

    var card = instance_create_layer(
        start_x + col * (card_w + spacing),
        start_y + row * (card_h + spacing),
        "Instances",
        obj_card
    );
    
    card.sprite_index = deck[| i];
    card.xx = col;
    card.flipped = false;
}

// create list to hold player’s selections
global.selected = ds_list_create();
