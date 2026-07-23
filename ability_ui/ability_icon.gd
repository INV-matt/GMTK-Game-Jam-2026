extends Control
class_name AbilityIcon

@onready var icon: TextureRect = %icon
@onready var countdown: RichTextLabel = %countdown

@export var ability: Ability

func _ready() -> void:
  icon.texture = ability.icon
  icon.material = icon.material.duplicate()

func _process(_delta: float) -> void:
  var progress: float = 1.0
  
  if ability.cooldown:
    countdown.text = "%.1f" % ability.cooldown.time_left
    progress = (ability.cooldown.wait_time - ability.cooldown.time_left) / ability.cooldown.wait_time

  (icon.material as ShaderMaterial).set_shader_parameter("progress", progress)

  countdown.visible = ability.cooldown and ability.cooldown.time_left > 0
