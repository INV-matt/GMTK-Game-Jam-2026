extends BaseUpgrade
class_name PlantHealth

@export var multiplier: float = 1.1

func upgrade_stats() -> void:
  Globals.PLANT_HEALTH_MULTIPLIER += multiplier - 1
