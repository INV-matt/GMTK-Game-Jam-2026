extends BaseUpgrade
class_name PlayerSpeed_3

@export var speed_multiplier = 1.5

func upgrade_stats() -> void:
  Globals.PLAYER_SPEED_MULTIPLIER += speed_multiplier - 1