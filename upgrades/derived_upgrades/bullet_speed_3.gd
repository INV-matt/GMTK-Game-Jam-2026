extends BaseUpgrade
class_name BulletSpeed_3

@export var speed_multiplier: float = 1.5
@export var pierce_modifier: int = 1

func upgrade_stats() -> void:
  Globals.BULLET_SPEED_MULTIPLIER += speed_multiplier - 1
  Globals.BULLET_PIERCE_MODIFIER += pierce_modifier