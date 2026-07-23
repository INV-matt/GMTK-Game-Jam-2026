extends Control
class_name SeedMngr

@onready var seed_container: VBoxContainer = %seed_container

var seeds: Dictionary[PlantResource, int] = {}

func update_seed_display() :
  for i in seed_container.get_children():
    i.queue_free()
  
  for i in seeds:
    if seeds[i] <= 0: continue
  
    var horizontal: HBoxContainer = HBoxContainer.new()
    
    var control: Control = Control.new()
    
    var sprite: TextureRect = TextureRect.new()
    sprite.texture = i.packet_sprite
    sprite.custom_maximum_size = Vector2(32, 32)
    
    control.add_child(sprite)
    control.custom_minimum_size = Vector2(32, 32)
    
    horizontal.add_child(control)
    
    var text: RichTextLabel = RichTextLabel.new()
    text.text = "x%d" % seeds[i]
    text.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    
    horizontal.add_child(text)
    
    seed_container.add_child(horizontal)

func add_seed(plant: PlantResource) -> void:
  if plant in seeds:
    seeds[plant] += 1
  else:
    seeds[plant] = 1
  
  update_seed_display()

func remove_seed(plant: PlantResource) -> void:
  if plant in seeds and seeds[plant] > 0:
    seeds[plant] -= 1
  
  update_seed_display()
