extends Resource
class_name PlantResource

@export var name: String = "Plant name"
@export_multiline() var desc: String = "Plant description"

@export var image: Texture2D

@export var stationary: bool = true

@export var growth_stages: int = 3
@export var growth_time: float = 15.0

@warning_ignore("unused_parameter")
func planted(pot: Pot):
  print("Planted")

@warning_ignore("unused_parameter")
func process(delta: float, pot: Pot, stage: int):
  print(stage)

@warning_ignore("unused_parameter")
func unplanted(pot: Pot):
  print("Unplanted")
