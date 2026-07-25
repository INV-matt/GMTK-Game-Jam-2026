extends Control

@onready var bar_player: ProgressBar = %player_bar
@onready var bar_plant: ProgressBar = %plant_bar

@onready var pl: Player = Qol.player
var connected = false

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
  if !pl:
    pl = Qol.player
  if pl:
    if !connected:
      pl.hp_comp.hurt.connect(update_player_bar)
      pl.hp_comp.healed.connect(update_player_bar)
      pl.hp_comp.died.connect(update_player_bar)

      update_player_bar(0)
      connected = true


@warning_ignore("unused_parameter")
func update_player_bar(amount: float) -> void:
  bar_player.max_value = Qol.player.hp_comp.max_hp
  bar_player.value = clamp(pl.hp_comp.hp, 0, Qol.player.hp_comp.max_hp)

func update_plant_bar() -> void:
  bar_plant.value = clamp(randi() % 100, 0, 100)
