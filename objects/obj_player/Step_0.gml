/// @Moving
key_up = keyboard_check( vk_up );
key_down = keyboard_check( vk_down );
key_left = keyboard_check( vk_left );
key_right = keyboard_check( vk_right );

if ( is_moving == false ) {
	// Ready to move
	if ( key_up ) {
		is_moving = true;
		to_move = grid_size;
		hsp = 0;
		vsp = -grid_speed;
	} else if ( key_down ) {
		is_moving = true;
		to_move = grid_size;
		hsp = 0;
		vsp = grid_speed;
	} else if ( key_left ) {
		is_moving = true;
		to_move = grid_size;
		hsp = -grid_speed;
		vsp = 0;
	} else if ( key_right ) {
		is_moving = true;
		to_move = grid_size;
		hsp = grid_speed;
		vsp = 0;
	}		
} 

// Immediately check if we should move to create smooth movement
if ( is_moving == true ) {
	// Within a move
	if ( to_move > 0 ) {
		x += hsp;
		y += vsp;
		to_move -= grid_speed;
	} 
	
	// Detect end of a move directly, so we do not lose a frame standing still
	if ( to_move <= 0 ) {
		is_moving = false;
	}
}
	
