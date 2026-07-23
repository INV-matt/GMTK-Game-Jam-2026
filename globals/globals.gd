extends Node

@export var PLAYER: Player

func _ready():
  if PLAYER == null:
    print("WTF")

func _process(delta: float) -> void: pass
