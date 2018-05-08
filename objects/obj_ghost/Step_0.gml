/// @desc Move the ghost

var dd = [ "-", "N", "E", "S", "W" ];

// This is the code for a ghost after a move is complete (ie. ghost is not moving)
if ( is_moving == false ) {
	
	// Act according to modes
	if ( mode == MODE.home ) {
		
		/*
		 * Enemy is inside spawning area
		 */
		 
		// Determine distance to door
		xdist = obj_door.x - x;
		ydist = obj_door.y - y;
		
		s = "";
		if ( xdist == 0 and ydist == 0 ) {
			// We reached the door, switch mode now and continue desired_dir for one more step
			mode = MODE.stray;
			s += ", dir: " + dd[desired_dir];
		} else {
		
			// Still searching the door, determine move possibilities, then move
			var free_pos = whats_free( x, y, obj_wall );
			
			// DEBUG for free_pos
			if ( free_pos[DIR.north] ) s += "N" else s += "-";
			if ( free_pos[DIR.south] ) s += "S" else s += "-";
			if ( free_pos[DIR.east] ) s += "E" else s += "-";
			if ( free_pos[DIR.west] ) s += "W" else s += "-";

			// End of DEBUG
			
			// Determine desired horizontal direction
			var desired_hor_dir = DIR.none;
			if ( xdist > 0 ) {
				desired_hor_dir = DIR.east;
			} else if ( xdist < 0 ) {
				desired_hor_dir = DIR.west;
			}
			s += ", hor: " + dd[desired_hor_dir];
			
			// Determine desired vertical direction
			var desired_ver_dir = DIR.none;
			if ( ydist > 0 ) {
				desired_ver_dir = DIR.south;
			} else if ( ydist < 0 ) {
				desired_ver_dir = DIR.north;
			}
			s += ", ver: " + dd[desired_ver_dir];
			
			// Prioritize moving direction
			desired_dir = DIR.none;
			if ( free_pos[desired_hor_dir] and free_pos[desired_ver_dir] ) {
				// Both desired directions are available, choose the most distant one
				if ( ( abs( xdist ) >= abs( ydist ) ) ) {
					desired_dir = desired_hor_dir;
				} else {
					desired_dir = desired_ver_dir;
				}
			} else if ( free_pos[desired_hor_dir] ) {
				// Only horizontal movement in desired direction is possible
				desired_dir = desired_hor_dir;
			} else if ( free_pos[desired_ver_dir] ) {
				// Only vertical movement in desired direction is possible
				desired_dir = desired_ver_dir;
			} else {
				// No movement in desired direction is possible
				desired_dir = DIR.none;
			}
			s += ", dir: " + dd[desired_dir];	
		}
		
		show_debug_message( "X=" + string(xdist) + ", Y=" + string(ydist) );
		show_debug_message( s );
	
	} else
	
	if ( mode == MODE.stray ) {
	
		/*
		 * Enemy is just walking around (no target)
		 */
		 
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