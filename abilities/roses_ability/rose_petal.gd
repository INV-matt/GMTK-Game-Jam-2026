extends CharacterBody2D
class_name RosePetal

const SPEED: float = 800

var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
  rotation = direction.angle()

func _physics_process(delta: float) -> void:
  velocity = direction * delta * 60 * SPEED * Globals.BULLET_SPEED_MULTIPLIER
  move_and_slide()

func _on_dmg_hitbox_expired() -> void:
  queue_free()
