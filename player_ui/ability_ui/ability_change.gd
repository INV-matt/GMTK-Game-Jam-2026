extends Button
class_name AbilityChange

@export var ability_idx: int = 0
@onready var ability_icon: TextureRect = %ability_icon
@onready var ability_text: RichTextLabel = %text

var connected: bool = false

func _ready() -> void:
  if ability_idx == 0:
    ability_text.text = "Primary Ability"
  elif ability_idx == 1:
    ability_text.text = "Secondary Ability"
  elif ability_idx == 2:
    ability_text.text = "Tertiary Ability"

func _process(_delta: float) -> void:
  if connected: return
  
  if Qol.player:
    Qol.player.ability_list_changed.connect(update_icon)
    connected = true

func update_icon():
  if len(Qol.player.abilities) > ability_idx:
    ability_icon.texture = Qol.player.abilities[ability_idx].icon
    ability_icon.visible = true
  else:
    ability_icon.visible = false
