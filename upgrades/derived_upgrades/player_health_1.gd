extends BaseUpgrade
class_name PlayerHealth_1

@export var health_multiplier = 1.1

func upgrade_stats() -> void:
  Globals.PLAYER_HEALTH_MULTIPLIER += health_multiplier - 1