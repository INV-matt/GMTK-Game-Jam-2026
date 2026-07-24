extends BaseUpgrade
class_name PlayerSpeed_1

@export var speed_multiplier = 1.2

func upgrade_stats() -> void:
  Globals.PLAYER_SPEED_MULTIPLIER += speed_multiplier - 1