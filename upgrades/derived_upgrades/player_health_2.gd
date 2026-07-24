extends BaseUpgrade
class_name PlayerHealth_2

@export var health_multiplier = 1.15

func upgrade_stats() -> void:
  Globals.PLAYER_HEALTH_MULTIPLIER += health_multiplier - 1