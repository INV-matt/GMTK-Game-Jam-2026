extends Control

@onready var txt_fps: Label = %fps

func _process(_delta: float) -> void:
  if Globals.DEBUG:
    visible = true
    txt_fps.text = "%d fps" % Engine.get_frames_per_second()
  else: visible = false
