extends BaseUpgrade
class_name BulletSpeed_2

@export var speed_multiplier = 1.3

func upgrade_stats() -> void:
  Globals.BULLET_SPEED_MULTIPLIER += speed_multiplier - 1