extends Node

@export var PLAYER: Player
var PLAYER_DAMAGE_MULTIPLIER: float = 1
var PLAYER_SPEED_MULTIPLIER: float = 1
var PLAYER_HEALTH_MULTIPLIER: float = 1
var BULLET_SPEED_MULTIPLIER: float = 1
var BULLET_PIERCE_MODIFIER: int = 0
var PLANT_HEALTH_MULTIPLIER: float = 1
var SAFE_ZONE_MULTIPLIER: float = 1
var GROW_SPEED_MULTIPLIER: float = 1

var enemy_killed = 0
var upgrades_unlocked = 0:
  get:
    var kills_needed = kills_for_next_upgrade()
    if enemy_killed > kills_needed: upgrades_unlocked += 1
    return upgrades_unlocked
func kills_for_next_upgrade() -> int:
  return 5 * int(pow(upgrades_unlocked + 1, 2))
