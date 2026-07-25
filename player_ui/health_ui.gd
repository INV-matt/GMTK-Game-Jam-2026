extends Control

@onready var bar_player: ProgressBar = %player_bar
@onready var bar_plant: ProgressBar = %plant_bar

@onready var pl: Player = Qol.player
var pl_connected = false

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
  if !pl: pl = Qol.player
  if pl && !pl_connected:
    pl.hp_comp.hurt.connect(update_player_bar)
    pl.hp_comp.healed.connect(update_player_bar)
    #pl.hp_comp.died.connect(update_player_bar)

    update_player_bar(0)
    pl_connected = true

  update_plant_bar()


@warning_ignore("unused_parameter")
func update_player_bar(amount: float) -> void:
  bar_player.max_value = Qol.player.hp_comp.max_hp
  bar_player.value = clamp(pl.hp_comp.hp, 0, Qol.player.hp_comp.max_hp)

func update_plant_bar() -> void:
  var total = 0
  var curr = 0
  for plant: Node in get_tree().get_nodes_in_group("plants"):
    var hp_comp: HpComp = Qol.find_hp_comp(plant)
    if hp_comp:
      total += hp_comp.max_hp
      curr += hp_comp.hp
      print("%s / %s" % [curr, total])
  bar_plant.value = clamp(curr, 0, total)
  bar_plant.max_value = total
