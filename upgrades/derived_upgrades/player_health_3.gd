extends BaseUpgrade
class_name PlayerHealth_3

@export var health_multiplier = 1.25

func upgrade_stats() -> void:
  Globals.PLAYER_HEALTH_MULTIPLIER += health_multiplier - 1