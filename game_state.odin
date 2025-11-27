package main

import "vendor:raylib"

Game_State :: struct {
    player_pos:   raylib.Vector2,
    player_speed: f32,
	
	// DVD state
	font_size: f32,
	text:      cstring,
	text_pos:  raylib.Vector2,
	text_vel:  raylib.Vector2,
}