@tool

extends Area2D
class_name InteractionComp

@export_range(0.0, 200.0, 0.5, "or_greater") var radius: float = 100.0
@export var tooltip_string: String = ""
@export var tooltip: RichTextLabel

@export var inherit_focus: InteractionComp

var player_inside: bool = false
var active: bool = true
var has_focus: bool = false

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
  
  Signals.focus_grabbed.connect(focus_grabbed)
  Signals.focus_lost.connect(focus_lost)
  
func focus_grabbed(who: InteractionComp):
  if who == self or who == inherit_focus:
    active = true
    has_focus = true
  else:
    active = false
    has_focus = false

func focus_lost():
  active = true
  has_focus = false

func _process(_delta: float) -> void:
  (collision.shape as CircleShape2D).radius = radius
  
  if Engine.is_editor_hint(): return
  
  if tooltip:
    tooltip.modulate.a = tooltip.modulate.a * .9 + (target_a if active else 0.0) * .1
  
  if active:
    if len(get_overlapping_bodies()) > 0:
      player_inside = true
      target_a = 1.0
      Signals.focus_grabbed.emit(self)
    else:
      player_inside = false
      target_a = 0.0
      Signals.focus_lost.emit()
    
    if !Engine.is_editor_hint() and player_inside and has_focus and Input.is_action_just_pressed("interact"):
      print("interacted")
      interacted.emit()

func _exit_tree() -> void:
  if has_focus:
    Signals.focus_lost.emit()
