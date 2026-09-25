package player_manager
import graph_lib "vendor:raylib"

Player_State :: enum {
    Alive,
    Dead,
}

Different_Player_Speed :: enum {
	Walk = 25,
	Run = 50,
}

Different_Player_Direction :: enum {
	Right = 1,
	Left = -1,
	Forward = 1,
	Backward = -1,
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
    players: [dynamic ; 4]Player,
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

move_player :: proc(player: ^Player, direction: [2]Different_Player_Direction, speed : Different_Player_Speed) {
	player.velocity = {f32(direction[0]) * f32(speed), f32(direction[1]) * f32(speed)}
    player.position = player.position + player.velocity * graph_lib.GetFrameTime()
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
