@tool

extends Hitbox
class_name DmgHitbox

@export var piercing: int = -1
@export var damage: float = 10

var pierced: int = 0

func _ready() -> void:
  super._ready()
  
  hit.connect(deal_dmg)

func deal_dmg(to_what: Hurtbox) -> void:
  var parent: Node = to_what.get_parent()
  var hp_comp: HpComp = Qol.find_hp_comp(parent)
  
  pierced += 1
  
  if pierced > piercing and piercing >= 0:
    expire()
  
  if !hp_comp:
    push_error("Could not find health component on node %s" % parent)
    return

  var final_damage = damage
  if team == Teams.Player: final_damage *= Globals.PLAYER_DAMAGE_MULTIPLIER
  
  hp_comp.damage(final_damage)
