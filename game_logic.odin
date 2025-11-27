package main

import "vendor:raylib"

init_game :: proc(text: cstring, font_size: f32, player_speed: f32) -> Game_State {
	
	text_size := raylib.MeasureTextEx(raylib.GetFontDefault(), text, font_size, 1.0)
	text_pos := raylib.Vector2{(f32(raylib.GetScreenWidth()) - text_size.x) / 2.0, (f32(raylib.GetScreenHeight()) - text_size.y) / 2.0}

    return Game_State{
        player_pos   = text_pos,
        player_speed = player_speed,
		font_size    = font_size,
		text         = text,
		text_vel     = raylib.Vector2{120, 90},
		text_pos     = text_pos,
    }
}

update_game :: proc(state: ^Game_State, dt: f32) {

	// player input
    if raylib.IsKeyDown(raylib.KeyboardKey.RIGHT) do state.player_pos[0] += state.player_speed * dt 
    if raylib.IsKeyDown(raylib.KeyboardKey.LEFT)  do state.player_pos[0] -= state.player_speed * dt 
    if raylib.IsKeyDown(raylib.KeyboardKey.UP)    do state.player_pos[1] -= state.player_speed * dt 
    if raylib.IsKeyDown(raylib.KeyboardKey.DOWN)  do state.player_pos[1] += state.player_speed * dt

	if raylib.IsMouseButtonDown(raylib.MouseButton.LEFT)  do state.font_size += 1
	if raylib.IsMouseButtonDown(raylib.MouseButton.RIGHT) do state.font_size -= 1

	// DVD text update	
	state.text_pos[0] += state.text_vel[0] * dt
	state.text_pos[1] += state.text_vel[1] * dt

	text_size := raylib.MeasureTextEx(raylib.GetFontDefault(), state.text, state.font_size, 1.0)

	if state.text_pos[0] < 0 || state.text_pos[0] + text_size.x > f32(raylib.GetScreenWidth()) do state.text_vel[0] = -state.text_vel[0]
	if state.text_pos[1] < 0 || state.text_pos[1] + text_size.y > f32(raylib.GetScreenHeight()) do state.text_vel[1] = -state.text_vel[1]
}

draw_game :: proc(state: ^Game_State) {
    raylib.ClearBackground({160, 160, 160, 255})

	// draw player
    raylib.DrawCircleV(state.player_pos, 20.0, raylib.BLUE)

	// draw DVD text
	raylib.DrawText(state.text, i32(state.text_pos[0]), i32(state.text_pos[1]), i32(state.font_size), raylib.MAROON)

}
