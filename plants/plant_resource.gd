extends Resource
class_name PlantResource

@export var name: String = "Plant name"
@export_multiline() var desc: String = "Plant description"

@export var stationary: bool = true
@export_range(0.0, 50.0, 0.5, "or_greater") var health: float = 100.0

@export var packet_sprite: Texture2D

@export_group("Growth")
@export var sprite_offset: Vector2 = Vector2.ZERO
@export var growth_stage_textures: Array[Texture2D]
@export_range(1.0, 30.0, 0.5, "or_greater") var growth_time: float = 30.0:
  get: return Globals.GROW_SPEED_MULTIPLIER * growth_time

@export_group("Abilities")
@export var give_ability: bool = false
@export var ability: Ability

@warning_ignore_start("unused_parameter")
func planted(pot: Pot) -> void: pass
func process(delta: float, pot: Pot, stage: int) -> void: pass
func unplanted(pot: Pot) -> void: pass
func grown(pot: Pot, stage: int) -> void:
  if give_ability:
    ability.plant_stage = stage
@warning_ignore_restore("unused_parameter")
