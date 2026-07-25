extends CanvasLayer

func _ready() -> void:
  visible = false
  Signals.open_options.connect(open_options)
  Signals.close_options.connect(close_options)

func open_options() -> void:
  visible = true

func close_options() -> void:
  visible = false

func toggle_fullscreen(value: bool) -> void:
  if value:
    DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
  else:
    DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)

func change_audio(value: float) -> void:
  var idx = AudioServer.get_bus_index("Master")
  var db = linear_to_db(value)
  AudioServer.set_bus_volume_db(idx, db)

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("ui_cancel") && visible:
    Signals.close_options.emit()