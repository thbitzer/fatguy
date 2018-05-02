/// @desc Move the ghost


// This is the code for a ghost after a move is complete
if ( is_moving == false ) {
	
	var prev_dir = desired_dir;
	if ( prev_dir = DIR.none ) {
		desired_dir = irandom( 4 );
	} else {
		new_dir = random( 1.0 );
		
		if ( new_dir < 0.7 ) {
			desired_dir = prev_dir;
			//global.stat_straight++;
		} else if ( new_dir < 0.825 ) {
			desired_dir = ( prev_dir mod 4 ) + 1;
			//global.stat_goright++; 
		} else if (new_dir < 0.95 ) {
			desired_dir = ( ( 5 - prev_dir ) div 4 ) * 4 + ( prev_dir - 1 );
			global.stat_goleft++;
		} else {
			desired_dir = ( prev_dir + 2 ) - ( prev_dir div 3 ) * 4;
			global.stat_backwards++;
		}
		global.stat_n++;
		show_debug_message( "Stat straight/right/left/back = " + 
			string( global.stat_straight/global.stat_n ) + ", " +
			string( global.stat_goright/global.stat_n ) + ", " +
			string( global.stat_goleft/global.stat_n ) + ", " +
			string( global.stat_backwards/global.stat_n ) );
	}
	
	// Ready to move
	if ( desired_dir == DIR.north ) {
		if ( ! place_meeting( x, y-grid_size, obj_wall ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = 0;
			vsp = -grid_speed;
		}
	} else if ( desired_dir == DIR.south ) {
		if ( ! place_meeting( x, y+grid_size, obj_wall ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = 0;
			vsp = grid_speed;
		}
	} else if ( desired_dir == DIR.west ) {
		if ( ! place_meeting( x-grid_size, y, obj_wall ) ) {
			is_moving = true;
			to_move = grid_size;
			hsp = -grid_speed;
			vsp = 0;
		}
	} else if ( desired_dir == DIR.east ) {
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