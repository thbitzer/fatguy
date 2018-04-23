/// @desc Print lives left

draw_set_colour( c_white );
draw_set_font( fnt_default );
draw_text( 500, 734, "Lives: " + string( global.game_live ) );