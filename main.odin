package main
import "core:fmt"
import graph_lib "vendor:raylib"
import map_manager "coordinates-manager"
import players_monitor "player-manager"

WINDOW_SIZE_HEIGHT : i32 : 1080
WINDOW_SIZE_WIDTH : i32 : 1920
GAME_FPS : i32 : 60
WINDOW_TITLE : cstring : "MVP graphical engine"
PLAYER_TILE: u8 : 2

draw_centered_minimap :: proc(map_to_draw : ^map_manager.Map) {
   if map_to_draw.mini_map.is_lazy_drawing_enable == true do return
     else {
    	mini_tile_size : u16 = 64;
	    start_tile_position : map_manager.Position = map_manager.Position{
						                            u16(graph_lib.GetScreenWidth() / 2) - (mini_tile_size * map_to_draw.mini_map.tile_size.col) / 2,
                                                    u16(graph_lib.GetScreenHeight() / 2) - (mini_tile_size * map_to_draw.mini_map.tile_size.row) / 2}
        //defer map_to_draw.mini_map.is_lazy_drawing_enable = true
        tile_position :=  start_tile_position
        for i : u16 = 0;  i < u16(len(map_to_draw.mini_map.map_representation)); i += u16(1) {
            if map_manager.convert_one_row_to_tile(i32(i), map_to_draw).x == 0 do tile_position.x = start_tile_position.x
            else do tile_position.x += mini_tile_size
            if map_manager.convert_one_row_to_tile(i32(i),map_to_draw).x == 0 && i != 0 do tile_position.y += mini_tile_size
            on_fly_rect : graph_lib.Rectangle = graph_lib.Rectangle{f32(tile_position.x), f32(tile_position.y), f32(mini_tile_size), f32(mini_tile_size)}
            graph_lib.DrawRectangleRec(on_fly_rect, graph_lib.GOLD)
            graph_lib.DrawRectangleLinesEx(on_fly_rect, 1, graph_lib.YELLOW)
        }
    }
}


main::proc() {
	beta_map := map_manager.Map{pixel_size = map_manager.Dimension{map_manager.OVERALL_PIXEL_SIZE * 10, map_manager.OVERALL_PIXEL_SIZE * 5},
	                            mini_map = {map_representation = []u8 {0..=10 = 0, 11..=18 = 1,
																		19..=20 = 0, 21..=28 = 1, 29..=30 = 0,
																		31..=38 = 1, 39..=40 = 0, 41..=48 = 1,
																	49 = 0}, diff_tiles_num = 2,
																    tile_size = map_manager.Dimension{10, 10},
																	is_centered = true,
																	is_lazy_drawing_enable = false}}
    player_manager := players_monitor.Player_Manager {
                                                        players = [dynamic; 4]players_monitor.Player{},
                                                        next_id = 0
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
            if (beta_map.mini_map.is_centered == true) do draw_centered_minimap(&beta_map)
        graph_lib.EndDrawing()
    }
}
