extends CanvasLayer

func _ready() -> void:
  visible = false

  Signals.start_game.connect(show)
