extends Node

var budget: int = 0
var current_wave: int = 0:
  get:
    return current_wave
  set(value):
    budget = calculate_budget(value)
    current_wave = value


@export var enemy_types: Dictionary[PackedScene, int]
@export_range(500, 2000, 10, "or_greater") var MINIMUM_DISTANCE: int
@export_range(1000, 5000, 10, "or_greater") var MAXIMUM_DISTANCE: int

var elapsed_time = 1.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  current_wave = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  if budget > 0:
    if elapsed_time < 0:
      elapsed_time = 1.
      spawn_enemy()
    else:
      elapsed_time -= delta

func spawn_enemy() -> void:
  var possible_enemies: Array[PackedScene]
  for key in enemy_types.keys():
    if enemy_types.get(key, budget) <= budget: possible_enemies.push_back(key)
  
  if possible_enemies.size() == 0:
    print("No possible enemies: ")
    print("Budget: ", budget)
    return
    
  var chosen: PackedScene = possible_enemies.pick_random() as PackedScene
  budget -= enemy_types.get(chosen)

  var enemy_node: BaseEnemy = chosen.instantiate() as BaseEnemy

  var theta = randf() * 2 * PI
  var rho = randf_range(MINIMUM_DISTANCE, MAXIMUM_DISTANCE)
  var pos = rho * Vector2(cos(theta), sin(theta))
  enemy_node.global_position = pos

  #print("Spawned %s at pos %s" % [enemy_node.name, enemy_node.global_position])
  Signals.spawned_enemy.emit(pos) # TODO: possibly implement ui indicator telling the player where the enemy spawned (like a small arrow)

  add_child(enemy_node)
  

func calculate_budget(value: int) -> int:
  return value * (value + 1) / 2
