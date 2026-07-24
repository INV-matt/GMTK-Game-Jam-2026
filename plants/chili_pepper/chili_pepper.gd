extends PlantResource
class_name ChiliPepper

const FIRE_RING = preload("uid://d0lfrcoj8ocwm")
var fire_ring: FireRing

func planted(pot: Pot) -> void:
  if fire_ring:
    fire_ring.queue_free()
    fire_ring = null

  fire_ring = FIRE_RING.instantiate()
  fire_ring.stage = 0
  pot.add_child(fire_ring)

func grown(pot: Pot, stage: int) -> void:
  if !fire_ring: return
  fire_ring.stage = stage

func unplanted(pot: Pot) -> void:
  if !fire_ring: return

  fire_ring.queue_free()
  fire_ring = null