extends CharacterBody2D
class_name BaseEnemy

@export var SPEED: float = 100:
  get():
    return SPEED * speed_mult
@export var MAX_HEALTH: float = 100
@export var DEFAULT_TARGET: Vector2
@export_range(1, 200, 1, "or_greater") var size: int = 25
@export var TIME_TARGET_UPDATE: float = 5.0

@onready var animation_tree: AnimationTree = %AnimationTree
@onready var sprite: Sprite2D = %sprite
@onready var hp_comp: HpComp = %HpComp
@onready var player_hitbox: DmgHitbox = %PlayerHitbox
@onready var hurtbox: Hurtbox = %Hurtbox
@onready var nav_agent: NavigationAgent2D = %nav_agent

var speed_mult: float = 1.0

var target: Vector2
var following_player: bool

var timer_target: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  target = get_plant_target()
  following_player = false
  hp_comp.max_hp = MAX_HEALTH
  animation_tree.active = true

  nav_agent.target_position = target
  nav_agent.velocity_computed.connect(Callable(on_velocity_computed))
  nav_agent.max_speed = SPEED * 1.2

  timer_target = Timer.new()
  timer_target.wait_time = TIME_TARGET_UPDATE
  timer_target.connect(retarget())

  
var target_velocity: Vector2
var delta_pos: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  delta_pos = SPEED * delta

  if (following_player):
    if (Qol.player.is_dead):
      following_player = false
      target = get_plant_target()
      nav_agent.target_position = target
    else:
      target = Qol.player.global_position
      nav_agent.target_position = target

  if nav_agent.is_navigation_finished(): return
  var next_pos: Vector2 = nav_agent.get_next_path_position()
  var new_vel: Vector2 = global_position.direction_to(next_pos) * delta_pos

  nav_agent.set_velocity(new_vel)

  velocity = velocity * 0.8 + target_velocity * 0.2

  move_and_slide()

func on_player_entered(body: Node2D) -> void:
  if body is Player: following_player = true

func on_player_exited(body: Node2D) -> void:
   if body is Player:
    following_player = false
    target = get_plant_target()
    nav_agent.target_position = target

func _on_hp_comp_died() -> void:
  Signals.enemy_died.emit()
  is_dead = true

func _process(_delta: float) -> void:
  animation_tree.set("parameters/Walk/blend_position", velocity.normalized())
  animation_tree.set("parameters/conditions/attack", hit_something)
  animation_tree.set("parameters/conditions/died", is_dead)

var is_dead: bool = false
var hit_something: bool = false

func _on_player_hitbox_hit(_what: Hurtbox) -> void:
  hit_something = true

func reset_hit():
  hit_something = false

func on_velocity_computed(safe_velocity: Vector2) -> void:
  target_velocity = safe_velocity * delta_pos * 20.0

func get_plant_target() -> Vector2:
  var plants = get_tree().get_nodes_in_group("plants")
  if plants.size() == 0:
    return Vector2.ZERO

  var min_dst: float = INF
  var pos_min: Vector2 = Vector2.ZERO

  for plant: Node2D in plants:
    var dst = plant.global_position.distance_squared_to(global_position)
    if dst < min_dst:
      min_dst = dst
      pos_min = plant.global_position

  return pos_min

func calculate_target

func retarget() -> void:
  target = get_plant_target()
