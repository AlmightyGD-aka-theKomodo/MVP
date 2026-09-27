package main
import "core:fmt"
import graph_lib "vendor:raylib"
import map_manager "coordinates-manager"
import players_monitor "player-manager"
import utils "tools"

WINDOW_SIZE_HEIGHT : i32 : 1080
WINDOW_SIZE_WIDTH : i32 : 1920
GAME_FPS : i32 : 60
WINDOW_TITLE : cstring : "MVP graphical engine"
PLAYER_TILE: u8 : 2

draw_centered_minimap :: proc(map_to_draw : ^map_manager.Map) {
	origin : map_manager.Position = map_manager.get_minimap_centered_origin(map_to_draw)
	pixel_minitile_position :=  origin
        for value, idx in map_to_draw.mini_map.map_representation {
            tile_minitile_position : map_manager.Position = map_manager.convert_one_row_to_tile(i32(idx), map_to_draw)
            pixel_minitile_position = map_manager.Position{origin.x + map_manager.CENTERED_MINI_TILE_SIZE * tile_minitile_position.x,
                                                           origin.y + map_manager.CENTERED_MINI_TILE_SIZE * tile_minitile_position.y}
            on_fly_rect : graph_lib.Rectangle = {f32(pixel_minitile_position.x), f32(pixel_minitile_position.y),
                                                 f32(map_manager.CENTERED_MINI_TILE_SIZE), f32(map_manager.CENTERED_MINI_TILE_SIZE)}
            color: graph_lib.Color
            switch value {
            	case 0:           		color = graph_lib.GOLD
             	case 1:           	   	color = graph_lib.DARKGRAY
            }
            graph_lib.DrawRectangleRec(on_fly_rect, color)
            graph_lib.DrawRectangleLinesEx(on_fly_rect, 1, graph_lib.YELLOW)
        }
}

draw_player_on_centered_minimap :: proc(m: ^map_manager.Map, player: ^players_monitor.Player) {
	center_player_on_tile : f32 = f32(map_manager.CENTERED_MINI_TILE_SIZE / 2)
	player_tile : map_manager.Position = map_manager.convert_pixel_to_tile(map_manager.Position{u16(player.position.x), u16(player.position.y)})
    origin : map_manager.Position = map_manager.get_minimap_centered_origin(m)
	player_origin := map_manager.Position{origin.x + map_manager.CENTERED_MINI_TILE_SIZE * player_tile.x,
                                          origin.y + map_manager.CENTERED_MINI_TILE_SIZE * player_tile.y}
    graph_lib.DrawCircleV([2]f32{f32(player_origin.x) + center_player_on_tile, f32(player_origin.y) + center_player_on_tile}, center_player_on_tile - 6, graph_lib.RED)
}

main::proc() {
	beta_map := map_manager.Map{pixel_size = map_manager.Dimension{map_manager.OVERALL_PIXEL_SIZE * 10, map_manager.OVERALL_PIXEL_SIZE * 5},
	                            mini_map = {map_representation = []u8 {0..=10 = 0,
																		11..=18 = 1, 19..=20 = 0,
																		21..=28 = 1, 29..=30 = 0,
																		31..=38 = 1,
																		39..=49 = 0},
																    tile_size = map_manager.Dimension{10, 5},
																	is_centered = true}}
    player_manager := players_monitor.Player_Manager {players = [dynamic; 4]players_monitor.Player{},
                                                      next_id = 0}
    players_monitor.add_player(&player_manager, "Player test", graph_lib.Vector2{64, 64})
    beta_player := players_monitor.get_player_by_id(&player_manager, 0)
    graph_lib.InitWindow(WINDOW_SIZE_WIDTH, WINDOW_SIZE_HEIGHT, WINDOW_TITLE)
    defer graph_lib.CloseWindow()
    graph_lib.SetTargetFPS(GAME_FPS)
    for graph_lib.WindowShouldClose() != true {
    	if (graph_lib.IsKeyPressed(graph_lib.KeyboardKey.F11) == true) {
     			graph_lib.ToggleFullscreen()
        }
        graph_lib.BeginDrawing()
            graph_lib.ClearBackground(graph_lib.RAYWHITE)
            //utils.player_move(&beta_map, players_monitor.get_player_by_id(&player_manager, 0))
            if (beta_map.mini_map.is_centered == true)  {
                draw_centered_minimap(&beta_map)
                draw_player_on_centered_minimap(&beta_map, beta_player)
            }
        graph_lib.EndDrawing()
    }
}
