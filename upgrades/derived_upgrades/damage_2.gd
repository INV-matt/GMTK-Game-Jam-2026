extends BaseUpgrade
class_name Damage_2

@export var damage_multiplier = 1.3

func upgrade_stats() -> void:
  Globals.PLAYER_DAMAGE_MULTIPLIER *= damage_multiplier