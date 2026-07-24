extends BaseUpgrade
class_name PlayerSpeed_2

@export var speed_multiplier = 1.3

func upgrade_stats() -> void:
  Globals.PLAYER_SPEED_MULTIPLIER += speed_multiplier - 1