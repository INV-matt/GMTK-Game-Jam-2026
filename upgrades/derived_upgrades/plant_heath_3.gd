extends BaseUpgrade
class_name PlantHealth_3

@export var health_multiplier: float = 1.25
@export var time_multiplier: float = 0.9

func upgrade_stats() -> void:
  Globals.PLANT_HEALTH_MULTIPLIER += health_multiplier - 1
  Globals.GROW_SPEED_MULTIPLIER += time_multiplier - 1
