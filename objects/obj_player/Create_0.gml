/// @desc Init

// This is for the desired_dir var
enum DIR {
	none,
	up,
	down,
	left,
	right
}

// Buffer for arrow keys
keyb_buffer = [ DIR.none, DIR.none, DIR.none, DIR.none ];

// The score of the game
global.player_score = 0;