extends CanvasLayer

var was_game_running: bool = true

func _ready() -> void:
  visible = false
  Signals.open_options.connect(open_options)
  Signals.close_options.connect(close_options)
  (%slider_volume as Slider).value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master"))
  (%slider_sfx as Slider).value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("ui_cancel"):
    if visible: Signals.close_options.emit()
    else: Signals.open_options.emit()

func open_options() -> void:
  visible = true
  was_game_running = !get_tree().paused
  Qol.pause_game()

func close_options() -> void:
  visible = false
  if was_game_running: Qol.unpause_game()

func toggle_fullscreen(value: bool) -> void:
  if value:
    DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
  else:
    DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)

func change_audio(value: float) -> void:
  var idx = AudioServer.get_bus_index("Master")
  var db = linear_to_db(value)
  AudioServer.set_bus_volume_db(idx, db)

func change_sfx(value: float) -> void:
  var idx = AudioServer.get_bus_index("SFX")
  var db = linear_to_db(value)
  AudioServer.set_bus_volume_db(idx, db)

func change_msaa(index: int) -> void:
  get_viewport().msaa_2d = index as Viewport.MSAA


func toggle_vsync(value: bool) -> void:
  if value: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
  else: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func back_pressed() -> void: Signals.close_options.emit()
func quit_pressed() -> void: get_tree().quit()


func toggle_debug(value: bool) -> void:
  Globals.DEBUG = value
