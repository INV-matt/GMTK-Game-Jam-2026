extends CharacterBody2D
class_name Pot

@onready var plant_icon: Sprite2D = %plant_icon
@onready var pot_icon: AnimatedSprite2D = %pot_icon
@onready var growth_progress: ProgressBar = %growth_progress
@onready var hp_comp: HpComp = %hp_comp
@onready var interaction_comp: InteractionComp = %interaction_comp
@onready var plantables: Node2D = %plantables

var is_dead = false

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
  
  growth = plant.growth_time - 5.0
  
  growth_progress.visible = true
  growth_progress.max_value = plant.growth_time
  
  plant_icon.position = Vector2(plant.sprite_offset.x, plant.sprite_offset.y - 24)
  
  hp_comp.max_hp = plant.health

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
  
  if growth_stage >= len(plant.growth_stage_textures):
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
  
  if Qol.player:
    var diff: Vector2 = Qol.player.global_position - global_position
    if diff.length_squared() > 100 * 100:
      var inside: bool = false
      for i: InteractionComp in plantables.get_children():
        if i.player_inside:
          inside = true
          break
      
      if !inside:
        hide_plantables()

func on_death() -> void:
  if is_dead: return
  is_dead = true
  hp_comp.disabled = true
  
  queue_free()
  
  if plant:
    plant.unplanted(self)
    if plant.give_ability:
      Qol.player.abilities.erase(plant.ability)
      Qol.player.ability_list_changed.emit()

  print("Plant died")

var push_dist: float = 75

func _physics_process(_delta: float) -> void:
  if Qol.player and !(plant and plant.stationary):
    var diff: Vector2 = global_position - Qol.player.global_position
    var dist: float = diff.length_squared()

    if dist <= push_dist * push_dist:
      velocity = diff.normalized() * 30.0
      move_and_slide()

func create_plantables():
  plantables.visible = true
  
  var available: Array[PlantResource] = []
  for i in Qol.seed_mngr.seeds:
    if Qol.seed_mngr.seeds[i] > 0:
      available.append(i)
  
  var idx: int = 0
  for i in available:
    var interact: InteractionComp = InteractionComp.new()
    interact.global_position = Vector2(((1 - len(available)) / 2.0 + idx) * 80, 64)
    interact.radius = 32
    interact.interacted.connect(func():
      if !plant:
        Qol.seed_mngr.remove_seed(i)
        plant = i
        plantables.visible = false
        for f in plantables.get_children():
          f.queue_free()
        interaction_comp.queue_free()
        $interaction_label.queue_free()
    )
    interact.inherit_focus = interaction_comp
    
    var icon: Sprite2D = Sprite2D.new()
    icon.texture = i.packet_sprite
    icon.scale = Vector2(.4, .4)
    icon.z_index = 30
    
    interact.add_child(icon)
    
    idx += 1
    
    plantables.add_child(interact)

func hide_plantables():
  plantables.visible = false
  for f in plantables.get_children():
    f.queue_free()

func _on_interaction_comp_interacted() -> void:
  if !plant:
    if !plantables.visible:
      create_plantables()
    else:
      hide_plantables()
