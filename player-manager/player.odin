package player_manager
import graph_lib "vendor:raylib"

Player_State :: enum {
    Alive,
    Dead,
}

Player :: struct {
    id: int,
    name: string,
    position: graph_lib.Vector2,
    velocity: graph_lib.Vector2,
    hp: int,
    max_hp: int,
    level: int,
    gold: int,
    xp: int,
    state: Player_State,
}

Player_Manager :: struct {
    players: [dynamic]Player,
    next_id: int,
}

add_player :: proc(manager: ^Player_Manager, name: string, position: graph_lib.Vector2) {
    player: Player = Player {
        name = name,
        position = position,
        velocity = graph_lib.Vector2{0.0, 0.0},
        hp = 100,
        max_hp = 100,
        level = 1,
        gold = 0,
        xp = 0,
        id = manager.next_id,
        state = Player_State.Alive,
    }
    append(&manager.players , player)
    manager.next_id += 1
    return
}

remove_player :: proc(manager: ^Player_Manager, player_id: int) {
	for i in 0..<len(manager.players) {
        if manager.players[i].id == player_id {
            unordered_remove(&manager.players, i)
            break
        }
    }
}

move_player :: proc(player: ^Player, direction: graph_lib.Vector2, speed: f32) {
    player.velocity = direction
    player.position.x += direction.x * speed
    player.position.y += direction.y * speed
}

damage_player :: proc(player: ^Player, damage: int) {
	if player.state == .Dead {
        return
	}

    player.hp -= damage

    if player.hp <= 0 {
        player.hp = 0
        player.state = .Dead
    }
}

get_player_by_id :: proc(manager: ^Player_Manager, id: int) -> ^Player {
    for i in 0 ..< len(manager.players) {
        if manager.players[i].id == id {
            return &manager.players[i]
        }
    }

    return nil
}

delete_player_manager :: proc(manager : ^Player_Manager) {
	delete(manager.players)
}
