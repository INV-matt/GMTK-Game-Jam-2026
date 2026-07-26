extends Node
class_name LevelMngr

var game_scene: PackedScene = preload("uid://bv0qgb712vbh3") # TODO: put game scene here, this is the debug scene

func _ready() -> void:
  Signals.start_game.connect(on_start_game)

func on_start_game() -> void:
  for n: Node in get_children(): n.free.call_deferred()
  
  await get_tree().process_frame

  var game_node = game_scene.instantiate()
  add_child.call_deferred(game_node)
