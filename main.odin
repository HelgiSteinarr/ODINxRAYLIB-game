package main

import "core:fmt"
import "core:math"
import "vendor:raylib"

main :: proc() {
    screen_width: f32 = 800
    screen_height: f32 = 450

	raylib.SetConfigFlags(raylib.ConfigFlags{
		raylib.ConfigFlag.WINDOW_ALWAYS_RUN,
		raylib.ConfigFlag.WINDOW_RESIZABLE,
        raylib.ConfigFlag.BORDERLESS_WINDOWED_MODE
	})
    raylib.InitWindow(i32(screen_width), i32(screen_height), "ODIN x RAYLIB")
    defer raylib.CloseWindow()

    raylib.SetTargetFPS(60)

	state := init_game("DVD", 20, 200)

    for !raylib.WindowShouldClose() {
		dt := math.min(raylib.GetFrameTime(), 0.05) // cap at 50ms

		update_game(&state, dt)

        raylib.BeginDrawing()
        draw_game(&state)
        raylib.EndDrawing()
       
    }
}

