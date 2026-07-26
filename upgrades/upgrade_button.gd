extends Control
class_name UpgradeButton

@export var upgrade: BaseUpgrade

@onready var btn: TextureButton = %btn
@onready var title: Label = %title
@onready var desc: Label = %desc
@onready var select_btn: Button = %select

func _ready() -> void:
  if Globals.DEBUG: print("hi")
  btn.pressed.connect(on_pressed)
  select_btn.pressed.connect(on_pressed)

func inizialize(up: BaseUpgrade) -> void:
  await get_tree().process_frame
  upgrade = up
  title.text = up.name
  desc.text = up.description
  #btn.texture_normal = up.icon

func on_pressed() -> void:
  Qol.game_mngr.handle_upgrade(upgrade)
  if Globals.DEBUG: print("hi")
