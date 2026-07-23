extends CharacterBody2D
class_name BaseEnemy

@export var SPEED: float = 100
@export var MAX_HEALTH: float = 10
@export var DEFAULT_TARGET: Vector2
@export var sprite: Sprite2D
@export_range(1, 200, 1, "greater than") var size: int = 25


var hp_comp: HpComp
var player_hitbox: DmgHitbox
var hurtbox: Hurtbox

var target: Vector2
var following_player: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  target = DEFAULT_TARGET
  following_player = false
  hp_comp = %HpComp
  player_hitbox = %PlayerHitbox
  hurtbox = %Hurtbox


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  var direction: Vector2 = target - global_position
  if following_player and !Globals.PLAYER.is_dead:
    var vec_to_player = Globals.PLAYER.global_position - global_position
    if direction.length_squared() > vec_to_player.length_squared(): direction = vec_to_player
  
  velocity = direction.normalized() * SPEED * delta * 60
  move_and_slide()


func on_player_entered(body: Node2D) -> void:
  if body is Player: following_player = true

func on_player_exited(body: Node2D) -> void:
   if body is Player: following_player = false
