extends Resource
class_name Ability
#base class for all abilities. Each ability should have its own effect inside it

@export var ability_name: String
@export_multiline() var description: String
@export var icon: Texture2D

var plant_stage: int = 1

var is_ready: bool = true

#implement this function in its children
@warning_ignore("unused_parameter")
func use_ability(player: Player, target: Vector2) -> void:
  if !is_ready: return
  
  apply_effect(player, target)

@warning_ignore("unused_parameter")
func apply_effect(player: Player, target: Vector2) -> void: pass

func set_cooldown(player: Player, time: float) -> void:
  is_ready = false
  
  var t: Timer = Timer.new()
  t.autostart = true
  t.wait_time = time
  t.timeout.connect(func():
    is_ready = true
    t.queue_free()
  )
  t.name = "%s - Cooldown" % ability_name
  
  player.add_child(t)
