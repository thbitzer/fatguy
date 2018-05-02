/// @desc Move the ghost


// This is the code for a ghost after a move is complete
if ( is_moving == false ) {
	
	if ( mode == MODE.home ) {
		
		xdist = obj_door.x - x;
		ydist = obj_door.y - y;
		
		if ( xdist == 0 and ydist == 0 ) {
			mode = MODE.stray;
		} else if ( abs( xdist ) >= abs( ydist ) ) {
			if ( xdist > 0 ) {
				desired_dir = DIR.east;
			} else if ( xdist < 0 ) {
				desired_dir = DIR.west;
			}
		} else {
			if ( ydist > 0 ) {
				desired_dir = DIR.south;
			} else if ( ydist < 0 ) {
				desired_dir = DIR.north;
			}
		}
		
		show_debug_message( "X=" + string(xdist) + ", Y=" + string(ydist) );
	
	} else if ( mode == MODE.stray ) {
	
		var prev_dir = desired_dir;
		if ( prev_dir = DIR.none ) {
			desired_dir = irandom( 4 );
		} else {
			new_dir = random( 1.0 );
		
			if ( new_dir < 0.7 ) {
				desired_dir = prev_dir;
			} else if ( new_dir < 0.825 ) {
				desired_dir = ( prev_dir mod 4 ) + 1; 
			} else if (new_dir < 0.95 ) {
				desired_dir = ( ( 5 - prev_dir ) div 4 ) * 4 + ( prev_dir - 1 );
			} else {
				desired_dir = ( prev_dir + 2 ) - ( prev_dir div 3 ) * 4;
			}
		}
	} // end MODE.stray
	
	// Ready to move
	if ( desired_dir == DIR.north ) {
		if ( ! ( place_meeting( x, y-grid_size, obj_wall ) or 
		       ( place_meeting( x, y-grid_size, obj_door ) and mode != MODE.home ) ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = 0;
			vsp = -grid_speed;
		}
	} else if ( desired_dir == DIR.south ) {
		if ( ! ( place_meeting( x, y+grid_size, obj_wall ) or
		       ( place_meeting( x, y+grid_size, obj_door ) and mode != MODE.home ) ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = 0;
			vsp = grid_speed;
		}
	} else if ( desired_dir == DIR.west ) {
		if ( ! ( place_meeting( x-grid_size, y, obj_wall ) or
		       ( place_meeting( x-grid_size, y, obj_door ) and mode != MODE.home ) ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = -grid_speed;
			vsp = 0;
		}
	} else if ( desired_dir == DIR.east ) {
		if ( ! ( place_meeting( x+grid_size, y, obj_wall ) or
		       ( place_meeting( x+grid_size, y, obj_door ) and mode != MODE.home ) ) ) {
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