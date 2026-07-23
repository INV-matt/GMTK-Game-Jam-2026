extends CharacterBody2D
class_name Pot

@onready var plant_icon: Sprite2D = %plant_icon
@onready var pot_icon: AnimatedSprite2D = %pot_icon

@onready var growth_progress: ProgressBar = %growth_progress

@export var plant: PlantResource:
  set(value):
    if plant:
      plant.unplanted(self)
    
    if value:
      plant = value.duplicate(true)
    else:
      if plant.give_ability:
        Qol.player.abilities.erase(plant.ability)
        Qol.player.ability_list_changed.emit()
      plant = null 
   
    if plant:
      plant.planted(self)
    
    update_stats()

func update_stats() -> void:
  if !is_node_ready(): return
  
  growth_progress.visible = false
  
  plant_icon.visible = false
  
  growth = 0.0
  growth_stage = 0
  fully_grown = false
  
  if !plant: return
  
  growth_progress.visible = true
  growth_progress.max_value = plant.growth_time
  
  plant_icon.position = Vector2(plant.sprite_offset.x, plant.sprite_offset.y - 24)

var growth: float = 0:
  set(value):
    growth = value
    growth_progress.value = value
    
var growth_stage: int = 0:
  set(value):
    growth_stage = value
    
    if plant:
      plant.grown(self, value)

func _ready() -> void:
  update_stats()

var fully_grown: bool = false

func advance_growth():
  growth -= plant.growth_time
  growth_stage += 1
  
  if plant.give_ability and growth_stage == 1:
    # IMPORTANT: Pass the ability as a reference, this is necessary
    Qol.player.abilities.append(plant.ability)
    Qol.player.ability_list_changed.emit()
  
  plant_icon.visible = true
  
  var stage_tex: Texture2D = plant.growth_stage_textures[growth_stage - 1]
  plant_icon.texture = stage_tex
  #plant_icon.offset.y = (128 - stage_tex.get_height()) / 2.0
  
  if growth_stage >= plant.growth_stages:
    fully_grown = true
    growth_progress.visible = false

func update_growth(delta: float) -> void:
  if fully_grown: return
  
  growth += delta
  
  if growth >= plant.growth_time:
    advance_growth()

func _process(delta: float) -> void:
  if plant:
    update_growth(delta)
    plant.process(delta, self, growth_stage)
