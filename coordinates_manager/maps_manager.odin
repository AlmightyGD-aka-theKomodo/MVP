package map_manager
import graph_lib "vendor:raylib"

OVERALL_PIXEL_SIZE : u16 : 64


Dimension :: struct {
	length , width : u16,
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
    tile_size : Dimension,
    mini_map : struct {
        map_representation : []u8,
        diff_tiles_num : u8,
        diff_tiles : []Tile,
    }
}
