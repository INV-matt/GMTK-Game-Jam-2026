@tool

extends Hitbox
class_name DmgHitbox

@export var damage: float = 10

func _ready() -> void:
  super._ready()
  
  hit.connect(deal_dmg)

func deal_dmg(to_what: Hurtbox) -> void:
  var parent: Node = to_what.get_parent()
  var hp_comp: HpComp

  for node: Node in parent.get_children():
    if node is HpComp:
      hp_comp = (node as HpComp)
      break
  
  if !hp_comp:
    push_error("Could not find health component on node %s" % parent)
    return
  
  hp_comp.damage(damage)
