package main
import "core:fmt"
import graph_lib "vendor:raylib"
import map_manager "coordinates_manager"

WINDOW_SIZE_HEIGHT : i32 : 540
WINDOW_SIZE_WIDTH : i32 : 960
GAME_FPS : i32 : 60
DELTA_TIME : f32 : 1.0 / cast(f32)GAME_FPS
WINDOW_TITLE : cstring : "MVP graphical engine"

main::proc() {
	beta_map := map_manager.Map{pixel_size = map_manager.Dimension{map_manager.OVERALL_PIXEL_SIZE * 10, map_manager.OVERALL_PIXEL_SIZE * 5},
	                            tile_size = map_manager.Dimension{10, 5},
	                            mini_map = {map_representation = []u8 {0..=10 = 0, 11..=18 = 1,
																			19..=20 = 0, 21..=28 = 1,
																			29..=30 = 0, 31..=38 = 1,
																			39..=40 = 0, 41..=48 = 1,
																			49 = 0},
                                            diff_tiles_num = 2},
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
