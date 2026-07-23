@tool

extends Area2D
class_name InteractionComp

@onready var collision: CollisionShape2D = %collision

@export_range(0.0, 200.0, 0.5, "or_greater") var radius: float = 100.0
@export var tooltip_string: String = ""
@export var tooltip: RichTextLabel

var player_inside: bool = false

signal interacted

var target_a: float = 0.0

func _ready() -> void:
  if !Engine.is_editor_hint() and tooltip:
    tooltip.modulate.a = 0.0
    tooltip.text = "[E] %s" % tooltip_string

func _process(_delta: float) -> void:
  if !Engine.is_editor_hint() and tooltip:
    tooltip.modulate.a = tooltip.modulate.a * .9 + target_a * .1
  
  (collision.shape as CircleShape2D).radius = radius
  
  if !Engine.is_editor_hint() and Input.is_action_just_pressed("interact"):
    interacted.emit()

func _on_body_entered(_body: Node2D) -> void:
  player_inside = true
  target_a = 1.0

func _on_body_exited(_body: Node2D) -> void:
  player_inside = false
  target_a = 0.0
