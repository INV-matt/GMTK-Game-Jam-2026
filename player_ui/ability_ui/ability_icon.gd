extends Button
class_name AbilityIcon

@onready var ability_icon: TextureRect = %icon
@onready var countdown: RichTextLabel = %countdown
@onready var button_hint: TextureRect = %button_hint

@export var ability: Ability
var ability_idx: int = 0

var stylebox: StyleBoxFlat = StyleBoxFlat.new()

func _ready() -> void:
  stylebox.bg_color = Color.TRANSPARENT
  stylebox.corner_radius_bottom_left = 3
  stylebox.corner_radius_bottom_right = 3
  stylebox.corner_radius_top_left = 3
  stylebox.corner_radius_top_right = 3
  add_theme_stylebox_override("normal", stylebox)
  add_theme_stylebox_override("hover", stylebox)
  
  ability_icon.texture = ability.icon
  ability_icon.material = ability_icon.material.duplicate()
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
  
  ability_icon.position = shake
  shake = Vector2.from_angle(randf_range(0, PI * 4)) * shake.length() * .8
  
  if ability.cooldown:
    countdown.text = "%.1f" % ability.cooldown.time_left
    progress = (ability.cooldown.wait_time - ability.cooldown.time_left) / ability.cooldown.wait_time

  (ability_icon.material as ShaderMaterial).set_shader_parameter("progress", progress)
  
  # Shake both when the ability is used and when it recharges
  if progress >= 1.0 != was_ready:
    shake = Vector2.from_angle(randf_range(0, PI * 4)) * 30
  
  was_ready = progress >= 1.0

  countdown.visible = ability.cooldown and ability.cooldown.time_left > 0

var selected: bool = false

func toggle_select():
  selected = !selected
  
  if selected:
    stylebox.bg_color = Color.YELLOW
    stylebox.bg_color.a = .75
  else:
    stylebox.bg_color = Color.TRANSPARENT
  
  add_theme_stylebox_override("normal", stylebox)
  add_theme_stylebox_override("hover", stylebox)
