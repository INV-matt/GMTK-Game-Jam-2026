extends Control

@onready var bar_player: TextureProgressBar = %player_bar
@onready var bar_plant: TextureProgressBar = %plant_bar

@onready var pl: Player = Qol.player
var pl_connected = false

func _ready() -> void:
  Signals.return_to_main_menu.connect(_reset)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
  if !pl: pl = Qol.player
  if pl && !pl_connected:
    var t: HpComp = pl.hp_comp
    if t.hurt.is_connected(update_player_bar): t.hurt.disconnect(update_player_bar)
    if t.healed.is_connected(update_player_bar): t.healed.disconnect(update_player_bar)

    pl.hp_comp.hurt.connect(update_player_bar, ConnectFlags.CONNECT_REFERENCE_COUNTED)
    pl.hp_comp.healed.connect(update_player_bar, ConnectFlags.CONNECT_REFERENCE_COUNTED)

    update_player_bar(0)
    pl_connected = true

  update_plant_bar()


@warning_ignore("unused_parameter")
func update_player_bar(amount: float) -> void:
  bar_player.max_value = Qol.player.hp_comp.max_hp
  bar_player.value = clamp(pl.hp_comp.hp, 0, Qol.player.hp_comp.max_hp)

var has_lost: bool = false

func update_plant_bar() -> void:
  var total = 0
  var curr = 0
  for plant: Node in get_tree().get_nodes_in_group("plants"):
    var hp_comp: HpComp = Qol.find_hp_comp(plant)
    if hp_comp:
      total += hp_comp.max_hp
      curr += hp_comp.hp
  bar_plant.value = clamp(curr, 0, total)
  bar_plant.max_value = total
  
  if total == 0 and Qol.wave_mngr and Qol.wave_mngr.current_wave > 0 and !has_lost:
    Signals.all_plants_died.emit()
    has_lost = true
    print("hi")

func _reset() -> void:
  has_lost = false
  pl = null
  pl_connected = false
