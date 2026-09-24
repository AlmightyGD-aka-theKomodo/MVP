package player_action
import graph_lib "vendor:raylib"
import map_manager "coordinates-manager"
import players_monitor "player_manager"
import "core:math"

PLAYER_SIZE : f32 : 32
PLAYER_SPEED : f32 : 200
WALL_TILE : i16 : 1

is_walkable :: proc(m: ^map_manager.Map, px, py: f32) -> bool {
    if px < 0 || py < 0 do return false
    tile := map_manager.convert_pixel_to_tile(map_manager.Position{u16(px), u16(py)})
    value := map_manager.get_tilemap(tile, m)
    return value != -1 && value != WALL_TILE
}

can_stand_at :: proc(m: ^map_manager.Map, x, y: f32) -> bool {
    r := PLAYER_SIZE - 1
    return is_walkable(m, x, y) &&
           is_walkable(m, x + r, y) &&
           is_walkable(m, x, y + r) &&
           is_walkable(m, x + r, y + r)
}

player_center_tile :: proc(p: ^players_monitor.Player) -> map_manager.Position {
    return map_manager.convert_pixel_to_tile(map_manager.Position{
        u16(p.position.x + PLAYER_SIZE / 2),
        u16(p.position.y + PLAYER_SIZE / 2),
    })
}

player_move :: proc(m: ^map_manager.Map, p: ^players_monitor.Player, direction: graph_lib.Vector2, dt: f32) {
    if direction.x == 0 && direction.y == 0 {
        p.velocity = {}
        return
    }
    dir := graph_lib.Vector2Normalize(direction)
    step := PLAYER_SPEED * dt
    old_tile := player_center_tile(p)

    next_x := p.position.x + dir.x * step
    if can_stand_at(m, next_x, p.position.y) do p.position.x = next_x

    next_y := p.position.y + dir.y * step
    if can_stand_at(m, p.position.x, next_y) do p.position.y = next_y

    p.velocity = dir * PLAYER_SPEED

    new_tile := player_center_tile(p)
    if new_tile != old_tile {
        map_manager.set_tilemap(old_tile, 0, m)
        map_manager.set_tilemap(new_tile, PLAYER_TILE, m)
    }
}
