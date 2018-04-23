/// @desc Moving Player

// Set movement, as soon as one of the arrow keys is pressed
if ( keyboard_check_pressed( vk_up ) ) {
	desired_dir = DIR.up;
}
if ( keyboard_check_pressed( vk_down ) ) {
	desired_dir = DIR.down;
}
if ( keyboard_check_pressed( vk_left ) ) {
	desired_dir = DIR.left;
}
if ( keyboard_check_pressed( vk_right ) ) {
	desired_dir = DIR.right;
}

// Reset movement, if the key matching desired_dir is released
if ( keyboard_check_released( vk_up ) && desired_dir == DIR.up ) {
	desired_dir = DIR.none;
}
if ( keyboard_check_released( vk_down ) && desired_dir == DIR.down ) {
	desired_dir = DIR.none;
}
if ( keyboard_check_released( vk_left ) && desired_dir == DIR.left ) {
	desired_dir = DIR.none;
}
if ( keyboard_check_released( vk_right ) && desired_dir == DIR.right ) {
	desired_dir = DIR.none;
}

if ( is_moving == false ) {
	
	// Do not continue, if collectables_left is zero
	if ( global.collectables_left == 0 ) {
		show_message( "You have collected everything! Score = " + string( global.game_score ) );
		game_restart();
	}
		
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
	
// Detect collision with collectable
if ( place_meeting( x, y, obj_collectable ) ) {
	coll = instance_nearest( x, y, obj_collectable );
	with ( coll ) { 
		global.game_score += score_for_object;
		global.collectables_left--;
		instance_destroy();
	}
}