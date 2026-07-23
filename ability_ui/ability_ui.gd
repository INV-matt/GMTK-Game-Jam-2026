extends Control
class_name AbilityUI

const ABILITY_ICON = preload("uid://cnvk0rkj0bwqg")

@onready var ability_tray: HBoxContainer = %ability_tray

var player: Player

func _process(_delta: float) -> void:
  if !player:
    player = Qol.player
    if player:
      player.ability_list_changed.connect(update_ability_tray)

func update_ability_tray() -> void:
  for i in ability_tray.get_children():
    i.queue_free()
  
  for i in player.abilities:
    var icon: AbilityIcon = ABILITY_ICON.instantiate()
    icon.ability = i
    ability_tray.add_child(icon)
    ability_tray.move_child(icon, 0)
