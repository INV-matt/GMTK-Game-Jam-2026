extends Node
class_name WaveMngr

var budget: int = 0
var current_wave: int = 0:
  get:
    return current_wave
  set(value):
    budget = calculate_budget(value)
    current_wave = value
    Signals.started_wave.emit(value)


@export var enemy_types: Dictionary[PackedScene, int]
@export_range(500, 2000, 10, "or_greater") var MINIMUM_DISTANCE: int
@export_range(1000, 5000, 10, "or_greater") var MAXIMUM_DISTANCE: int
@export_range(0, 5, 0.1, "prefer_slider") var TIME_BETWEEN_ENEMIES: float = 0.5
@export var HEALTH_INCREASE_WAVES: float = 10
@export_range(1, 20, 1, "or_greater") var WAVES_BETWEEN_HEALTH_INCREASE: int = 10

var elapsed_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  current_wave = 1
  elapsed_time = TIME_BETWEEN_ENEMIES
  Signals.enemy_died.connect(on_enemy_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  if budget > 0:
    if elapsed_time < 0:
      elapsed_time = TIME_BETWEEN_ENEMIES
      spawn_enemy()
    else:
      elapsed_time -= delta

  if Input.is_action_just_pressed("ui_accept"): current_wave += 1

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

  var health_increase = HEALTH_INCREASE_WAVES * int(float(current_wave) / float(WAVES_BETWEEN_HEALTH_INCREASE))
  enemy_node.MAX_HEALTH += health_increase

  #print("Spawned %s at pos %s" % [enemy_node.name, enemy_node.global_position])
  Signals.spawned_enemy.emit(pos) # TODO: possibly implement ui indicator telling the player where the enemy spawned (like a small arrow)
  on_enemy_spawned()
  add_child(enemy_node)


func calculate_budget(value: int) -> int:
  return value * (value + 1)

func next_wave() -> void:
  enemy_alive = 0
  enemy_total = 0
  Signals.enemy_change.emit(0, 0)
  current_wave += 1
  Signals.started_wave.emit(current_wave)


var enemy_alive: int = 0
var enemy_total: int = 0
func on_enemy_spawned() -> void:
  enemy_alive += 1
  enemy_total += 1
  Signals.enemy_change.emit(enemy_alive, enemy_total)

func on_enemy_died() -> void:
  enemy_alive = max(enemy_alive - 1, 0)
  Signals.enemy_change.emit(enemy_alive, enemy_total)
