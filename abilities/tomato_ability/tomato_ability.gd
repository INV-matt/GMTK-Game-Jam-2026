extends Ability

const TOMATO_PROJECTILE = preload("uid://b212pucf44le5")

func apply_effect(player: Player, target: Vector2) -> void:
  var proj: TomatoProjectile = TOMATO_PROJECTILE.instantiate()
  proj.target = target
  proj.global_position = player.global_position
  proj.stage = plant_stage
  
  Qol.add_to_tree(proj)
  
  set_cooldown(2.0)
