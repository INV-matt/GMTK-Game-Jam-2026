extends BaseUpgrade
class_name BulletSpeed_1

@export var speed_multiplier = 1.2

func upgrade_stats() -> void:
  Globals.BULLET_SPEED_MULTIPLIER += speed_multiplier - 1