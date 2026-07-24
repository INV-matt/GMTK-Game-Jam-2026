extends Ability

const LAVENDER_PARTICLE = preload("uid://dfyd1os38ckwx")

var max_tp_range: float = 300.0

func apply_effect(player: Player, target: Vector2) -> void:
  var diff: Vector2 = target - player.global_position

  var modified_tp_range = max_tp_range * Globals.PLAYER_SPEED_MULTIPLIER
  
  var blink_by: Vector2 = (diff.normalized() * modified_tp_range) if diff.length_squared() > modified_tp_range * modified_tp_range else diff
  
  var end_pos: Vector2 = player.global_position + blink_by
  
  for i in [0.0, 0.25, 0.5, 0.75]:
    var part: GPUParticles2D = LAVENDER_PARTICLE.instantiate()
    part.global_position = player.global_position + (end_pos - player.global_position) * i
  
    Qol.add_to_tree(part)
  
  player.global_position = end_pos
  
  print(plant_stage)
  
  set_cooldown(4.5 / plant_stage)
