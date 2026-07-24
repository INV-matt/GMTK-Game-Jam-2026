extends Control

@onready var scn_upgrade_btn: PackedScene = preload("uid://by6wbcyexcmhn")
@onready var btn_container: HBoxContainer = $Panel/btn_container

func _ready() -> void: pass
  #visible = false

func on_open() -> void:
  visible = true

func on_close() -> void:
  visible = false


func display_upgrades(upgrades: Array[BaseUpgrade]) -> void:
  for node in btn_container.get_children(): node.queue_free()
  
  for upgrade: BaseUpgrade in upgrades:
    var btn_upgrade: UpgradeButton = scn_upgrade_btn.instantiate() as UpgradeButton
    btn_container.add_child.call_deferred(btn_upgrade) # it should be deferred, right?
