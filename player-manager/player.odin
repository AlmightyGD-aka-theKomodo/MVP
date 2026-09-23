package player_manager

Vector2f :: struct {
    x, y: f32,
}

Player_State :: enum {
    Alive,
    Dead,
}

Player :: struct {
    id: int,
    name: string,
    position: Vector2f,
    velocity: Vector2f,
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

add_player :: proc(manager: ^Player_Manager, name: string, position: Vector2f) -> ^Player {
    player: Player = Player{
        name = name,
        position = position,
        velocity = Vector2f{0.0, 0.0},
        hp = 100,
        max_hp = 100,
        level = 1,
        gold = 0,
        xp = 0,
        state = Player_State.Alive,
    }
    manager.players.append(player)
    manager.next_id += 1
    return &manager.players[manager.players.len - 1]
}

remove_player :: proc(manager: ^Player_Manager, player_id: int) {
    for i in 0..manager.players.len {
        if manager.players[i].id == player_id {
            manager.players.remove(i)
            break
        }
    }
}

move_player :: proc(player: ^Player, direction: Vector2f, speed: f32) {
    player.velocity = direction
    player.position.x += direction.x * speed
    player.position.y += direction.y * speed
}

damage_player :: proc(player: ^Player, damage: int) {
    if player.state == .Dead {
        return
    }

    player.health -= damage

    if player.health <= 0 {
        player.health = 0
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
