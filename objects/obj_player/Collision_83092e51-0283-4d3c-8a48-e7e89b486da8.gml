/// @desc Player runs into ghost

global.game_live--;

if ( global.game_live > 0 ) {
	show_message( "You were hit by a ghost. Score = " + string( global.player_score ) );
	is_moving = false;
	to_move = 0;
	vsp = 0;
	hsp = 0;
	keyb_buffer_reset();
	x = xstart;
	y = ystart;
} else {
	show_message( "GAME OVER. You lost all your lives. Score = " + string( global.player_score ) );
	game_end();
}
