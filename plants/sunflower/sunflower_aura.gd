extends Node2D
class_name SunflowerAura

@onready var animated_sprite: AnimatedSprite2D = %animated_sprite
@onready var collider: DmgHitbox = %collider

var target_scale: float = 0

@export var stage: int = 0:
  set(value):
    stage = value
    
    if !is_node_ready(): return
    
    animated_sprite.visible = false
    collider.set_deferred("disabled", false)
    
    if stage <= 0: return
  
    animated_sprite.visible = true
    animated_sprite.play("stage%s" % stage)
    target_scale = .1 + .05 * (stage - 1)
    collider.set_deferred("disabled", true)

func _ready() -> void:
  stage = 0

func _process(_delta: float) -> void:
  animated_sprite.scale = animated_sprite.scale * .9 + Vector2.ONE * target_scale * .1
  collider.scale = collider.scale * .9 + Vector2(10, 5.4) * target_scale * .1
