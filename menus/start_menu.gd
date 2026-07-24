extends CanvasLayer

@onready var btn_start: Button = %start
@onready var btn_options: Button = %options
@onready var btn_quit: Button = %quit

func _ready():
  btn_start.pressed.connect(on_start)
  btn_options.pressed.connect(on_options)
  btn_quit.pressed.connect(on_quit)


func on_start() -> void:
  Signals.start_game.emit()
  visible = false

func on_options() -> void:
  Signals.open_options.emit()

func on_quit() -> void:
  get_tree().quit()
