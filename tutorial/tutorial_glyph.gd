@tool

extends Node2D
class_name TutorialGlyph

@onready var sprite: Sprite2D = %sprite
@onready var text: RichTextLabel = %text
@onready var anim: AnimationPlayer = %anim

@export var action_name: String = ""
@export var action_icon: Texture2D
@export var sprite_scale: Vector2 = Vector2(.25, .25)

@export var action_desc: String = ""
@export var action_group: Array[TutorialGlyph] = []

var completed: bool = false

func _ready() -> void:
  sprite.texture = action_icon
  text.text = action_desc
  sprite.scale = sprite_scale
  action_group.append(self)

func _process(_delta: float) -> void:
  if Engine.is_editor_hint():
    sprite.scale = sprite_scale
    sprite.texture = action_icon
    text.text = action_desc
    return
  
  if !completed:
    if Input.is_action_pressed(action_name):
      completed = true
      anim.play("fade_away")
  elif len(action_group.filter(func(x):
    if is_instance_valid(x):
      return !x.completed
    return false
  )) == 0:
    anim.play("fade_away_fr")
