extends Ability

var max_tp_range: float = 200.0

func apply_effect(player: Player, target: Vector2) -> void:
  var diff: Vector2 = target - player.global_position
  
  player.global_position += (diff.normalized() * max_tp_range) if diff.length_squared() > max_tp_range * max_tp_range else diff
  
  set_cooldown(4.5 / plant_stage)
