extends Control
class_name UpgradeButton

@export var upgrade: BaseUpgrade

@onready var title: Label = %title
@onready var desc: Label = %desc
@onready var select_btn: TextureButton = %select
@onready var bg: Panel = %bg

var colors: Array[Color] = [
  Color(0.129, 0.725, 0.0),
  Color(0.792, 0.545, 0.0),
  Color(1.0, 0.0, 0.086)
]

func _ready() -> void:
  if Globals.DEBUG: print("hi")
  select_btn.pressed.connect(on_pressed)

func inizialize(up: BaseUpgrade) -> void:
  await get_tree().process_frame
  upgrade = up
  title.text = up.name
  desc.text = up.description

  var new_style: StyleBoxFlat = bg.get_theme_stylebox("panel").duplicate()
  new_style.set("bg_color", colors[upgrade.level - 1])
  bg.add_theme_stylebox_override("panel", new_style)
  #btn.texture_normal = up.icon

func on_pressed() -> void:
  Qol.game_mngr.handle_upgrade(upgrade)
  if Globals.DEBUG: print("hi")
