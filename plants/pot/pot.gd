extends CharacterBody2D
class_name Pot

@onready var plant_icon: Sprite2D = %plant_icon
@onready var pot_icon: AnimatedSprite2D = %pot_icon

@onready var growth_progress: ProgressBar = %growth_progress

@onready var hp_comp: HpComp = %hp_comp
var is_dead = false

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
  fully_grown = false
  
  if !plant: return
  
  growth_progress.visible = true
  growth_progress.max_value = plant.growth_time

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
  hp_comp.died.connect(on_death)
  hp_comp.max_hp = plant.health

var fully_grown: bool = false

func advance_growth():
  growth -= plant.growth_time
  growth_stage += 1
  
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


func on_death() -> void:
  if is_dead: return
  is_dead = true
  hp_comp.disabled = true
  
  queue_free()

  print("Plant died")