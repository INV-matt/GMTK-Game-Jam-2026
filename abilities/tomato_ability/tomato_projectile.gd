extends CharacterBody2D
class_name TomatoProjectile

const TOMATO_SPLATTER = preload("uid://dmtmkf5hguqyr")

@onready var sprite: Sprite2D = %sprite

var stage: int = 0

var target: Vector2
var start: Vector2

var t: float = 0.0
var spd: float = 0.0

func _ready() -> void:
  start = global_position
  spd = 500 / (start - target).length() * Globals.BULLET_SPEED_MULTIPLIER

func _process(delta: float) -> void:
  t = min(1.0, t + delta * spd)
  
  sprite.rotation += .1
  sprite.position.y = -sin(t * PI) * 250 / spd
  
  global_position = start + (target - start) * t
  
  if t >= 1:
    var splat: TomatoSplatter = TOMATO_SPLATTER.instantiate()
    splat.global_position = global_position
    splat.stage = stage
    
    Qol.add_to_tree(splat)
    queue_free()
