extends CharacterBody2D
class_name Pot

@onready var plant_icon: Sprite2D = %plant_icon
@onready var growth_progress: ProgressBar = %growth_progress

@export var plant: PlantResource:
  set(value):
    if plant:
      plant.unplanted(self)
    
    plant = value
    
    if plant:
      plant.planted(self)
      update_stats()

func update_stats() -> void:
  if !is_node_ready(): return
  
  growth_progress.visible = false
  plant_icon.visible = false
  growth = 0.0
  growth_stage = 0
  
  plant_icon.visible = true
  plant_icon.texture = plant.image
  plant_icon.scale = Vector2(
    64.0 / plant.image.get_width(),
    64.0 / plant.image.get_height(),
  )
  
  growth_progress.visible = true
  growth_progress.max_value = plant.growth_time

var growth: float = 0:
  set(value):
    growth = value
    growth_progress.value = value
var growth_stage: int = 0

func _ready() -> void:
  update_stats()

func _process(delta: float) -> void:
  if plant:
    growth += delta
    if growth >= plant.growth_time and growth_stage < plant.growth_stages:
      growth -= plant.growth_time
      growth_stage += 1
    
    plant.process(delta, self, growth_stage)
