/// @desc Player runs into ghost

global.game_live--;

if ( global.game_live > 0 ) {
	show_message( "You were hit by a ghost. Score = " + string( global.game_score ) );
	room_restart();
} else {
	show_message( "You lost all your lives. Score = " + string( global.game_score ) );
	game_end();
}
