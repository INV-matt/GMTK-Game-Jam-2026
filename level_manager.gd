extends Node
class_name LevelMngr

var game_scene: PackedScene = preload("uid://bv0qgb712vbh3") # TODO: put game scene here, this is the debug scene

func _ready() -> void:
  Signals.start_game.connect(on_start_game)


func on_start_game() -> void:
  var game_node = game_scene.instantiate()
  add_child(game_node)
