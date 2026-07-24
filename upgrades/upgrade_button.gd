extends Control
class_name UpgradeButton

@export var upgrade: BaseUpgrade

@onready var btn: TextureButton = %btn
@onready var title: Label = %title
@onready var desc: Label = %desc

func _ready() -> void:
  title.text = upgrade.name
  desc.text = upgrade.description
  btn.texture_normal = upgrade.icon
  btn.pressed.connect(on_pressed)

func on_pressed() -> void:
  upgrade.upgrade_stats()
