package main
import "core:fmt"
import graph_lib "vendor:raylib"
import "coordinates_manager"

// constant = SCREAMING_SNAKE_CASE

WINDOW_SIZE_HEIGHT : i32 : 540
WINDOW_SIZE_WIDTH : i32 : 960
GAME_FPS : i32 : 60
DELTA_TIME : f32 : 1.0 / cast(f32)GAME_FPS
WINDOW_TITLE : cstring : "MVP graphical engine"

main::proc() {
	beta_map := map_manager.Map{pixel_size = map_manager.Dimension{map_manager.OVERALL_PIXEL_SIZE * 10, map_manager.OVERALL_PIXEL_SIZE * 5},
	                            tile_size = map_manager.Dimension{10, 5},
	                            tile = {},
	                            minimap = {map_representation = [10][5]u8 {
																    0 = {0..=9 = 0},
																    1 = {0 = 0, 1..=8 = 1, 9 = 0},
																	2 = {0 = 0, 1..=8 = 1, 9 = 0},
																	3 = {0 = 0, 1..=8 = 1, 9 = 0},
																    4 = {0..=9 = 0},
                                                                },
                                diff_tiles_num = 2,
					        }
	            }
    graph_lib.InitWindow(WINDOW_SIZE_WIDTH, WINDOW_SIZE_HEIGHT, WINDOW_TITLE)

    graph_lib.SetTargetFPS(GAME_FPS)
    for graph_lib.WindowShouldClose() != true  {
        graph_lib.BeginDrawing();
            graph_lib.ClearBackground(graph_lib.RAYWHITE);
            graph_lib.DrawText("Damn bro!", 190, 200, 20, graph_lib.LIGHTGRAY);
        graph_lib.EndDrawing();
    }
    graph_lib.CloseWindow()
}
