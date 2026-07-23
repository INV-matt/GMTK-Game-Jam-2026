@tool

extends Area2D
class_name InteractionComp

@export_range(0.0, 200.0, 0.5, "or_greater") var radius: float = 100.0
@export var tooltip_string: String = ""
@export var tooltip: RichTextLabel

var player_inside: bool = false
var active: bool = true

signal interacted

var target_a: float = 0.0

var collision: CollisionShape2D

func _ready() -> void:
  collision_layer = 0
  collision_mask = 8
  
  collision = CollisionShape2D.new()
  collision.shape = CircleShape2D.new()
  
  add_child(collision)
  
  if !Engine.is_editor_hint() and tooltip:
    tooltip.modulate.a = 0.0
    tooltip.text = "[E] %s" % tooltip_string

func _process(_delta: float) -> void:
  if !Engine.is_editor_hint() and tooltip:
    tooltip.modulate.a = tooltip.modulate.a * .9 + (target_a if active else 0.0) * .1
  
  (collision.shape as CircleShape2D).radius = radius
  
  if len(get_overlapping_bodies()) > 0:
    player_inside = true
    target_a = 1.0
  else :
    player_inside = false
    target_a = 0.0
  
  if !Engine.is_editor_hint() and player_inside and active and Input.is_action_just_pressed("interact"):
    interacted.emit()
