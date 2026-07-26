extends Control

@export var atlases_to_cache: Array[AtlasTexture] = []

@onready var container: VBoxContainer = %container
@onready var progress: ProgressBar = %progress

func _ready() -> void:
  for i in atlases_to_cache:
    var h: HBoxContainer = HBoxContainer.new()
    
    var c: CheckBox = CheckBox.new()
    c.button_mask = 0
    
    h.add_child(c)
    
    var txt: RichTextLabel = RichTextLabel.new()
    txt.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    txt.text = "%s - %s x %s" % [i.atlas, i.get_width(), i.get_height()]
    
    h.add_child(txt)
    
    container.add_child(h)
  
  progress.max_value = len(atlases_to_cache)

var idx: int = 0
var elapsed: float = 0.0

func _process(delta: float) -> void:
  elapsed += delta
  
  if elapsed <= .1: return
  
  Qol.atlas_to_texture(atlases_to_cache[idx])
  
  (container.get_child(idx + 2).get_child(0) as CheckBox).button_pressed = true
  
  idx += 1
  
  progress.value = idx
  
  if idx >= len(atlases_to_cache):
    queue_free()
