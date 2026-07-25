extends Control

@onready var scn_upgrade_btn: PackedScene = preload("uid://by6wbcyexcmhn")
@onready var btn_container: HBoxContainer = $Panel/btn_container

func _ready() -> void:
  visible = false
  #Signals.open_upgrades.connect(on_open)
  Signals.killed_enough_enemies.connect(on_open)
  Signals.close_upgrades.connect(on_close)

func on_open() -> void:
  visible = true
  Qol.pause_game()

  for node in btn_container.get_children(): node.queue_free()
  
  var upgrades: Array[BaseUpgrade] = Qol.game_mngr.choose_random_upgrades()

  for upgrade: BaseUpgrade in upgrades:
    var btn_upgrade: UpgradeButton = scn_upgrade_btn.instantiate() as UpgradeButton
    btn_container.add_child(btn_upgrade)
    btn_upgrade.inizialize(upgrade)

func on_close() -> void:
  visible = false
  Qol.unpause_game()
  Signals.upgrade_ui_closed.emit()
