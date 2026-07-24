extends Control
class_name AbilityIcon

@onready var icon: TextureRect = %icon
@onready var countdown: RichTextLabel = %countdown
@onready var button_hint: TextureRect = %button_hint

@export var ability: Ability
var ability_idx: int = 0

func _ready() -> void:
  icon.texture = ability.icon
  icon.material = icon.material.duplicate()
  button_hint.texture = button_hint.texture.duplicate()
  button_hint.visible = true
  if ability_idx == Qol.player.primary_ability_idx:
    (button_hint.texture as AtlasTexture).region.position.x = 0
    (button_hint.texture as AtlasTexture).region.position.y = 0
  elif ability_idx == Qol.player.secondary_ability_idx:
    (button_hint.texture as AtlasTexture).region.position.x = 290
    (button_hint.texture as AtlasTexture).region.position.y = 0
  elif ability_idx == Qol.player.tertiary_ability_idx:
    (button_hint.texture as AtlasTexture).region.position.x = 0
    (button_hint.texture as AtlasTexture).region.position.y = 238
  else:
    button_hint.visible = false

var shake: Vector2 = Vector2.ZERO
var was_ready: bool = true

func _process(_delta: float) -> void:
  var progress: float = 1.0
  
  icon.position = shake
  shake = Vector2.from_angle(randf_range(0, PI * 4)) * shake.length() * .8
  
  if ability.cooldown:
    countdown.text = "%.1f" % ability.cooldown.time_left
    progress = (ability.cooldown.wait_time - ability.cooldown.time_left) / ability.cooldown.wait_time

  (icon.material as ShaderMaterial).set_shader_parameter("progress", progress)
  
  # Shake both when the ability is used and when it recharges
  if progress >= 1.0 != was_ready:
    shake = Vector2.from_angle(randf_range(0, PI * 4)) * 30
  
  was_ready = progress >= 1.0

  countdown.visible = ability.cooldown and ability.cooldown.time_left > 0
