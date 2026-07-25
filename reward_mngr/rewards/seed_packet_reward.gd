extends Reward

const SEED_PACKET = preload("uid://bcd41okr0r845")

@export var plant: PlantResource

func give_reward():
  var packet: SeedPacket = SEED_PACKET.instantiate()
  packet.plant = plant
  
  var dist: float = randf_range(800, 2000)
  
  packet.global_position = Vector2.from_angle(randf_range(-PI*2, PI*2)) * dist
  
  Qol.add_to_tree(packet)
