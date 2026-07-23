extends Ability

const ROSE_PETAL = preload("uid://dhj7xm6p75r6t")

func apply_effect(plant_stage: int, player: Player, target: Vector2) -> void:
  var dir: Vector2 = (target - player.global_position).normalized()
    
  for i in range(plant_stage):
    var petal: RosePetal = ROSE_PETAL.instantiate()
    petal.direction = dir
    petal.global_position += dir * i * 50
    
    player.get_tree().get_root().add_child.call_deferred(petal)
