extends Resource
class_name PlantResource

@export var name: String = "Plant name"
@export_multiline() var desc: String = "Plant description"

@export var stage_textures: Array[Texture2D]

@export var stationary: bool = true

@export var growth_stages: int = 3
@export var growth_time: float = 15.0

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
