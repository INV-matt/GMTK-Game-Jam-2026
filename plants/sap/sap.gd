extends PlantResource

const TREE_SAP = preload("uid://bn0kutc77y6mx")

var cooldown: float = 0

func process(delta: float, pot: Pot, stage: int) -> void:
  if stage == 0: return
  
  cooldown -= delta
  
  if cooldown > 0: return
  
  var enemies: Array[Node] = pot.get_tree().get_nodes_in_group("enemy")
  enemies.sort_custom(func(a: CharacterBody2D, b: CharacterBody2D):
    return a.global_position.distance_squared_to(pot.global_position) < b.global_position.distance_squared_to(pot.global_position)
  )
  var sap_range: float = 450.0 * stage
  
  for i: BaseEnemy in enemies.slice(0, stage):
    var diff: Vector2 = i.global_position - pot.global_position
    
    if diff.length_squared() < sap_range * sap_range:
      var sap: Node2D = TREE_SAP.instantiate()
      sap.global_position = i.global_position
      
      Qol.add_to_tree(sap)
      
      cooldown = 5.0
