extends PlantResource

const SUNFLOWER_AURA = preload("uid://bgmj8085qi2n")

var aura: SunflowerAura

func planted(pot: Pot) -> void:
  if aura:
    aura.queue_free()
    aura = null
  
  aura = SUNFLOWER_AURA.instantiate()
  aura.stage = 0
  pot.add_child(aura)

func grown(_pot: Pot, stage: int) -> void:
  if !aura: return
  
  aura.stage = stage

func unplanted(_pot: Pot) -> void:
  if !aura: return
  
  aura.queue_free()
  aura = null
