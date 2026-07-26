extends BaseUpgrade
class_name SafeRadius

@export var safe_radius_multiplier: float = 1.2

func upgrade_stats() -> void:
  Globals.SAFE_ZONE_MULTIPLIER += safe_radius_multiplier - 1