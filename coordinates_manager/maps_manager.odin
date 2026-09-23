package map_manager
import graph_lib "vendor:raylib"

OVERALL_PIXEL_SIZE : i32 : 64


Vector2i :: struct {
	x , y : i32,
}

Map :: struct {
    pixel_size : Vector2i,
    tile : struct {
        has_texture : bool,
        texture_path : cstring,
        color : graph_lib.Color,
        obj : graph_lib.Rectangle
    },

    mini_map : struct {
        map_rep : [tile_size.x][tile_size.y]int,
        diff_tiles_num : i32,
        diff_tiles : [diff_tiles_num]tile,
    }
}
