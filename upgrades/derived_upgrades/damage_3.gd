extends BaseUpgrade
class_name Damage_3

@export var damage_multiplier = 1.5

func upgrade_stats() -> void:
  Globals.PLAYER_DAMAGE_MULTIPLIER += damage_multiplier - 1