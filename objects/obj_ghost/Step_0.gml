/// @desc Move the ghost



if ( is_moving == false ) {
	
	desired_dir = irandom( 4 );
	
	// Ready to move
	if ( desired_dir == DIR.up ) {
		if ( ! place_meeting( x, y-grid_size, obj_wall ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = 0;
			vsp = -grid_speed;
		}
	} else if ( desired_dir == DIR.down ) {
		if ( ! place_meeting( x, y+grid_size, obj_wall ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = 0;
			vsp = grid_speed;
		}
	} else if ( desired_dir == DIR.left ) {
		if ( ! place_meeting( x-grid_size, y, obj_wall ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = -grid_speed;
			vsp = 0;
		}
	} else if ( desired_dir == DIR.right ) {
		if ( ! place_meeting( x+grid_size, y, obj_wall ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = grid_speed;
			vsp = 0;
		}
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