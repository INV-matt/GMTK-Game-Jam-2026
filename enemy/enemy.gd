extends CharacterBody2D

@export var SPEED: float
@export var MAX_HEALTH: float
@export var DEFAULT_TARGET: Vector2

@export var hp_comp: HpComp
@export var hitbox: DmgHitbox
@export var hurtbox: Hurtbox

var target: Vector2
var following_player: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  target = DEFAULT_TARGET
  following_player = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  var direction: Vector2 = target - global_position
  if following_player and !Globals.PLAYER.is_dead:
    var vec_to_player = Globals.PLAYER.global_position - global_position
    if direction.length_squared() > vec_to_player.length_squared(): direction = vec_to_player
  
  velocity = direction.normalized() * SPEED
  move_and_slide()


func on_player_entered(body: Node2D) -> void:
  if body is Player: following_player = true

func on_player_exited(body: Node2D) -> void:
   if body is Player: following_player = false
