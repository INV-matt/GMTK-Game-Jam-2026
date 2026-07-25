extends Ability

func apply_effect(player: Player, target: Vector2) -> void:
  print("hi")
  
  var diff: Vector2 = target - player.global_position
  
  var hitbox: DmgHitbox = DmgHitbox.new()
  hitbox.damage = 10
  hitbox.custom_shape = CircleShape2D.new()
  (hitbox.custom_shape as CircleShape2D).radius = 50
  hitbox.global_position = player.global_position + diff.normalized() * 50
  hitbox.lifetime = .1
  
  Qol.add_to_tree(hitbox)
  
  set_cooldown(.5)
