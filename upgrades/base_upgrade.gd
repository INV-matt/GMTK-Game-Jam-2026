extends Resource
class_name BaseUpgrade

@export var name: String
@export_multiline var description: String
@export var icon: Texture2D
@export var minimum_wave: int
@export var kill_to_unlock: int
@export var descendant_upgrades: Array[BaseUpgrade]

@warning_ignore_start("unused_parameter")

# func upgrade_player(player: Player) -> void: pass
func upgrade_stats() -> void: pass
# func upgrade_greenhouse() -> void: pass

@warning_ignore_restore("unused_parameter")