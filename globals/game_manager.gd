extends Node
class_name GameMngr

var available_upgrades: Array[BaseUpgrade]
@export var starter_upgrades: Array[BaseUpgrade]

func _ready() -> void:
  available_upgrades = starter_upgrades.duplicate_deep()

func handle_upgrade(upgrade: BaseUpgrade) -> void:
  upgrade.upgrade_stats()
  available_upgrades.erase(upgrade)
  for up: BaseUpgrade in upgrade.descendant_upgrades: available_upgrades.push_back(up)

  Signals.close_upgrades.emit()

var num_upgrades_to_display = 3
func choose_random_upgrades() -> Array[BaseUpgrade]:
  available_upgrades.shuffle()
  # TODO: add logic to include only upgrades unlocked (upgrade.kill_required < kill_total) if we want to implement it
  return available_upgrades.slice(0, num_upgrades_to_display)
