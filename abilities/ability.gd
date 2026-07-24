extends Resource
class_name Ability
#base class for all abilities. Each ability should have its own effect inside it

@export var ability_name: String
@export_multiline() var description: String
@export var icon: Texture2D

var plant_stage: int = 0

var is_ready: bool = true

# implement this function in its children
@warning_ignore("unused_parameter")
func use_ability(player: Player, target: Vector2) -> void:
  if !is_ready: return
  
  apply_effect(player, target)

@warning_ignore("unused_parameter")
func apply_effect(player: Player, target: Vector2) -> void: pass

var cooldown: Timer

func set_cooldown(time: float) -> void:
  is_ready = false
  
  if cooldown:
    cooldown.timeout.emit()
    cooldown.queue_free()
    cooldown = null
  
  cooldown = Timer.new()
  cooldown.autostart = true
  cooldown.wait_time = time
  cooldown.timeout.connect(func():
    is_ready = true
    cooldown.queue_free()
  )
  cooldown.name = "%s - Cooldown" % ability_name
  
  Qol.add_to_tree(cooldown)
