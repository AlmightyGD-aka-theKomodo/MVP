package map_manager
import graph_lib "vendor:raylib"

OVERALL_PIXEL_SIZE : u16 : 64


Dimension :: struct {
    col , row : u16,
}

Position :: struct {
	x , y : u16
}

Tile :: struct {
    has_texture : bool,
    texture_path : cstring,
    color : graph_lib.Color,
    obj : graph_lib.Rectangle,
    symbol : u8
}

Map :: struct {
    pixel_size : Dimension,
    mini_map : struct {
        map_representation : []u8,
        diff_tiles_num : u8,
        diff_tiles : []Tile,
        is_centered : bool,
        is_lazy_drawing_enable : bool,
        tile_size : Dimension,
    }
}

convert_pixel_to_tile :: proc(pos_in_pixel : Position) -> Position {
	return Position{pos_in_pixel.x / OVERALL_PIXEL_SIZE, pos_in_pixel.y / OVERALL_PIXEL_SIZE}
}

convert_tile_to_pixel :: proc(pos_in_tile : Position) -> Position {
	return Position{pos_in_tile.x * OVERALL_PIXEL_SIZE, pos_in_tile.y * OVERALL_PIXEL_SIZE}
}

convert_one_row_to_tile :: proc(index : i32, map_to_modify : ^Map) -> Position {
	return Position{u16(index) %% map_to_modify.mini_map.tile_size.col, u16(index) / map_to_modify.mini_map.tile_size.col}
}

set_tilemap :: proc(index : Position, value : u8, map_to_modify : ^Map) -> bool {
	if index.x > map_to_modify.mini_map.tile_size.col - 1 || index.y > map_to_modify.mini_map.tile_size.row - 1 {
		return false
    } else {
        map_to_modify.mini_map.map_representation[index.y * map_to_modify.mini_map.tile_size.col + index.x] = value
	    return true
    }
}

get_tilemap :: proc(index : Position, map_to_check : ^Map) -> i16 {
    if index.x > map_to_check.mini_map.tile_size.col - 1 || index.y > map_to_check.mini_map.tile_size.row - 1 do return -1
    else do return i16(map_to_check.mini_map.map_representation[index.y * map_to_check.mini_map.tile_size.col + index.x])
}

add_u16_to_position :: proc (to_add : u16, position : ^Position) {
	position.x += to_add
    position.y += to_add
}
