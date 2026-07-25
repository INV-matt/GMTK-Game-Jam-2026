extends CanvasLayer

var game_started: bool = false

func _ready() -> void:
  visible = false

  Signals.start_game.connect(
    func():
      visible = true
      game_started = true
  )

  Signals.open_options.connect(hide)
  Signals.close_options.connect(
    func(): visible = game_started
  )
