extends Ability

const PUNCH_ABILTY_VFX = preload("uid://djbmr4x712ofn")

func apply_effect(player: Player, target: Vector2) -> void:
  var diff: Vector2 = target - player.global_position
  
  var hitbox: DmgHitbox = DmgHitbox.new()
  hitbox.damage = 10
  hitbox.custom_shape = CircleShape2D.new()
  (hitbox.custom_shape as CircleShape2D).radius = 50
  hitbox.global_position = player.global_position + diff.normalized() * 75
  hitbox.lifetime = .1
  
  var spr: Sprite2D = Sprite2D.new()
  spr.texture = PUNCH_ABILTY_VFX
  spr.scale = Vector2(.1, .1)
  spr.rotation = diff.angle() + PI
  
  hitbox.add_child(spr)
  
  Qol.add_to_tree(hitbox)
  
  set_cooldown(.5)
