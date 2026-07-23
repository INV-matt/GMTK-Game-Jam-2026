extends Node2D
class_name TomatoSplatter

@onready var hitbox: DmgHitbox = %hitbox
@onready var sprite: Sprite2D = %sprite

var stage: int = 0

func _ready() -> void:
  sprite.scale = Vector2.ONE * (.05 + .05 * stage)

func _on_timer_timeout() -> void:
  hitbox.damage = 1

func _on_hitbox_expired() -> void:
  queue_free()
