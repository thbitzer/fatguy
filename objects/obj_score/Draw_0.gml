/// @desc Print current score

draw_set_colour(c_white);
draw_set_font(fnt_default);
draw_text(17,734,"Score: " + string( global.game_score ) );
