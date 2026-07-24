extends BaseUpgrade
class_name Damage_1

@export var damage_multiplier = 1.2

func upgrade_stats() -> void:
  Globals.PLAYER_DAMAGE_MULTIPLIER *= damage_multiplier