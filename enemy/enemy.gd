extends CharacterBody2D
class_name BaseEnemy

@export var SPEED: float = 100:
  get():
    return SPEED * speed_mult
@export var MAX_HEALTH: float = 100
@export var DEFAULT_TARGET: Vector2
@export_range(1, 200, 1, "or_greater") var size: int = 25

@onready var animation_tree: AnimationTree = %AnimationTree
@onready var sprite: Sprite2D = %sprite
@onready var hp_comp: HpComp = %HpComp
@onready var player_hitbox: DmgHitbox = %PlayerHitbox
@onready var hurtbox: Hurtbox = %Hurtbox
@onready var nav_agent: NavigationAgent2D = %nav_agent

var speed_mult: float = 1.0

var target: Vector2
var following_player: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  target = DEFAULT_TARGET
  following_player = false
  hp_comp.max_hp = MAX_HEALTH
  animation_tree.active = true

  nav_agent.target_position = DEFAULT_TARGET
  nav_agent.velocity_computed.connect(Callable(on_velocity_computed))
  nav_agent.max_speed = SPEED * 1.2

var target_velocity: Vector2
var delta_pos: float # |v*dt|

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  # var direction: Vector2 = target - global_position
  # if following_player and !Qol.player.is_dead:
  #   var vec_to_player = Qol.player.global_position - global_position
  #   if direction.length_squared() > vec_to_player.length_squared(): direction = vec_to_player
  # velocity = direction.normalized() * SPEED * delta * 60
  # if !hit_something and !is_dead:
  #   move_and_slide()

  delta_pos = SPEED * delta

  if (following_player):
    if (Qol.player.is_dead):
      following_player = false
      target = DEFAULT_TARGET
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
    target = DEFAULT_TARGET
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
