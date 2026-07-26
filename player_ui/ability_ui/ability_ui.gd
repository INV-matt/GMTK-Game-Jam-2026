extends Control
class_name AbilityUI

const ABILITY_ICON = preload("uid://cnvk0rkj0bwqg")

@onready var ability_tray: HBoxContainer = %ability_tray
@onready var fullscreen: HBoxContainer = %fullscreen
@onready var bg_col: ColorRect = %bg_col

var player: Player

var can_open: bool = true

func _ready() -> void:
  fullscreen.visible = false
  bg_col.visible = false
  Signals.start_game.connect(on_game_start)
  Signals.focus_grabbed.connect(func(_x: InteractionComp): can_open = false)
  Signals.focus_lost.connect(func(): can_open = true)

func _process(_delta: float) -> void:
  if !player:
    player = Qol.player
    if player:
      player.ability_list_changed.connect(update_ability_tray)
  elif can_open:
    if Input.is_action_just_pressed("interact"):
      fullscreen.visible = !fullscreen.visible
    
      if fullscreen.visible:
        if get_tree().paused:
          fullscreen.visible = false
        else:
          Qol.pause_game()
      else:
        selected = null
        for i: AbilityIcon in ability_tray.get_children():
          if i.selected: i.toggle_select()
        Qol.unpause_game()
        
      bg_col.visible = fullscreen.visible

func update_ability_tray() -> void:
  for i in ability_tray.get_children():
    i.queue_free()
  
  var idx: int = 0
  for i in player.abilities:
    var icon: AbilityIcon = ABILITY_ICON.instantiate()
    icon.ability = i
    icon.ability_idx = idx
    icon.pressed.connect(clicked_ability.bind(icon))
    ability_tray.add_child(icon)
    ability_tray.move_child(icon, 0)
    
    idx += 1

var selected: AbilityIcon = null

func clicked_ability(icon: AbilityIcon):
  for i: AbilityIcon in ability_tray.get_children():
    if i.selected and i != icon: i.toggle_select()
  
  icon.toggle_select()
  
  if icon.selected:
    selected = icon
  else:
    selected = null

func on_game_start() -> void: visible = true

func swap_abilities(from: int, to: int):
  var buffer := Qol.player.abilities[from]
  Qol.player.abilities[from] = Qol.player.abilities[to]
  Qol.player.abilities[to] = buffer
  Qol.player.ability_list_changed.emit()

func _on_swap_primary_pressed() -> void:
  if !selected: return
  if len(Qol.player.abilities) < 2: return
  swap_abilities(0, Qol.player.abilities.find(selected.ability))

func _on_swap_secondary_pressed() -> void:
  if !selected: return
  if len(Qol.player.abilities) < 2: return
  swap_abilities(1, Qol.player.abilities.find(selected.ability))

func _on_swap_tertiary_pressed() -> void:
  if !selected: return
  if len(Qol.player.abilities) < 3: return
  swap_abilities(2, Qol.player.abilities.find(selected.ability))
