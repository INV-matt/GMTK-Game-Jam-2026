extends Control
class_name AbilityUI

const ABILITY_ICON = preload("uid://cnvk0rkj0bwqg")

@onready var ability_tray: HBoxContainer = %ability_tray
@onready var fullscreen_ability: Control = %fullscreen_ability

var player: Player

func _ready() -> void:
  fullscreen_ability.visible = false
  Signals.start_game.connect(on_game_start)

func _process(_delta: float) -> void:
  if !player:
    player = Qol.player
    if player:
      player.ability_list_changed.connect(update_ability_tray)
      print(player)

func update_ability_tray() -> void:
  print(player.abilities)
  
  for i in ability_tray.get_children():
    i.queue_free()
  
  var idx: int = 0
  for i in player.abilities:
    var icon: AbilityIcon = ABILITY_ICON.instantiate()
    icon.ability = i
    icon.ability_idx = idx
    ability_tray.add_child(icon)
    ability_tray.move_child(icon, 0)
    
    idx += 1

func on_game_start() -> void: visible = true
