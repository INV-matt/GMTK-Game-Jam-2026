extends Control
class_name UpgradeButton

@export var upgrade: BaseUpgrade

@onready var btn: TextureButton = %btn
@onready var title: Label = %title
@onready var desc: Label = %desc
@onready var debug_btn: Button = %debug

func _ready() -> void:
  print("hi")
  btn.pressed.connect(on_pressed)

func inizialize(up: BaseUpgrade) -> void:
  await get_tree().process_frame
  upgrade = up
  title.text = up.name
  desc.text = up.description
  btn.texture_normal = up.icon

func on_pressed() -> void:
  Qol.game_mngr.handle_upgrade(upgrade)
  print("hi")
