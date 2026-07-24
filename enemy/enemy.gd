extends CharacterBody2D
class_name BaseEnemy

@export var SPEED: float = 100
@export var MAX_HEALTH: float = 100
@export var DEFAULT_TARGET: Vector2
@export_range(1, 200, 1, "or_greater") var size: int = 25

@onready var animation_tree: AnimationTree = %AnimationTree
@onready var sprite: Sprite2D = %sprite
@onready var hp_comp: HpComp = %HpComp
@onready var player_hitbox: DmgHitbox = %PlayerHitbox
@onready var hurtbox: Hurtbox = %Hurtbox

var target: Vector2
var following_player: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  target = DEFAULT_TARGET
  following_player = false
  hp_comp.max_hp = MAX_HEALTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  var direction: Vector2 = target - global_position
  if following_player and !Qol.player.is_dead:
    var vec_to_player = Qol.player.global_position - global_position
    if direction.length_squared() > vec_to_player.length_squared(): direction = vec_to_player
  
  velocity = direction.normalized() * SPEED * delta * 60
  
  if !hit_something and !is_dead:
    move_and_slide()


func on_player_entered(body: Node2D) -> void:
  if body is Player: following_player = true

func on_player_exited(body: Node2D) -> void:
   if body is Player: following_player = false

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
