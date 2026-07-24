extends Node2D

# TODO: Actually make ts slow enemies

@onready var sprite: Sprite2D = %sprite

var life: float = 0.0

func _process(delta: float) -> void:
  sprite.scale = sprite.scale * .9 + (Vector2(.3, .3) if life < 10 else Vector2.ZERO) * .1
  life += delta
  
  if life > 10 and sprite.scale.length() < .1:
    queue_free()

func _on_enemy_detect_body_entered(body: BaseEnemy) -> void:
  body.speed_mult = .5

func _on_enemy_detect_body_exited(body: BaseEnemy) -> void:
  body.speed_mult = 1.0
