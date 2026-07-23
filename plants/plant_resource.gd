extends Resource
class_name PlantResource

@export var name: String = "Plant name"
@export_multiline() var desc: String = "Plant description"

@export var stationary: bool = true
@export_range(0.0, 50.0, 0.5, "or_greater") var health: float = 10.0

@export_group("Growth")
@export var sprite_offset: Vector2 = Vector2.ZERO
@export var growth_stage_textures: Array[Texture2D]
@export_range(1, 5, 1, "or_greater") var growth_stages: int = 3
@export_range(1.0, 30.0, 0.5, "or_greater") var growth_time: float = 15.0

@export_group("Abilities")
@export var give_ability: bool = false
@export var ability: Ability

@warning_ignore("unused_parameter")
func planted(pot: Pot) -> void:
  print("Planted")

@warning_ignore("unused_parameter")
func process(delta: float, pot: Pot, stage: int) -> void:
  print("Process")

@warning_ignore("unused_parameter")
func grown(pot: Pot, stage: int) -> void:
  print("Grown to stage: %s" % stage)

@warning_ignore("unused_parameter")
func unplanted(pot: Pot) -> void:
  print("Unplanted")
