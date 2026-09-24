package main
import "core:fmt"
import graph_lib "vendor:raylib"
import map_manager "coordinates-manager"
import players_monitor "player_manager"

WINDOW_SIZE_HEIGHT : i32 : 1080
WINDOW_SIZE_WIDTH : i32 : 1920
GAME_FPS : i32 : 60
DELTA_TIME : f32 : 1.0 / cast(f32)GAME_FPS
WINDOW_TITLE : cstring : "MVP graphical engine"
PLAYER_TILE: u8 : 2

//draw_centered_minimap(minimap) {
//}


main::proc() {
	beta_map := map_manager.Map{pixel_size = map_manager.Dimension{map_manager.OVERALL_PIXEL_SIZE * 10, map_manager.OVERALL_PIXEL_SIZE * 5},
	                            mini_map = {map_representation = []u8 {0..=10 = 0, 11..=18 = 1,
																		19..=20 = 0, 21..=28 = 1, 29..=30 = 0,
																		31..=38 = 1, 39..=40 = 0, 41..=48 = 1,
																	49 = 0}, diff_tiles_num = 2,
																    tile_size = map_manager.Dimension{5, 5},}}

    player_manager := players_monitor.Player_Manager {
                                                        players = []players_monitor.Player{}, next_id = 0
                                                    }
    players_monitor.add_player(&player_manager, "Player Fredsk", graph_lib.Vector2{100, 100})

    player_tile := map_manager.Position{1, 1}
    map_manager.set_tilemap(
        player_tile,
        PLAYER_TILE,
        &beta_map,
    )
                                                                
    graph_lib.InitWindow(WINDOW_SIZE_WIDTH, WINDOW_SIZE_HEIGHT, WINDOW_TITLE)
    defer graph_lib.CloseWindow()
    graph_lib.SetTargetFPS(GAME_FPS)
    for graph_lib.WindowShouldClose() != true  {
        graph_lib.BeginDrawing()
            graph_lib.ClearBackground(graph_lib.RAYWHITE)
        graph_lib.EndDrawing()
    }
}
