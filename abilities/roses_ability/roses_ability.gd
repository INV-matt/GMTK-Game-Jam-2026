extends Ability

const ROSE_PETAL = preload("uid://dhj7xm6p75r6t")

func apply_effect(player: Player, target: Vector2) -> void:
  var dir: Vector2 = (target - player.global_position).normalized()
  
  for i in range(plant_stage):
    var petal: RosePetal = ROSE_PETAL.instantiate()
    petal.direction = dir
    petal.global_position = player.global_position
    petal.global_position += dir * i * 50
    
    Qol.add_to_tree(petal)

  set_cooldown(1.25)
