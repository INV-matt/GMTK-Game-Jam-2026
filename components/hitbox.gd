@tool

extends Area2D
class_name Hitbox

enum Teams {
  Player = 4,
  Enemy = 2,
}

@export var size: Vector2 = Vector2(20, 20)
@export var team: Teams = Teams.Player
@export var iframe_group: String = ""
@export var iframe_length: float = .5

var attacker: Node

@export var custom_shape: Shape2D
var shape: CollisionShape2D

func _ready() -> void:
  if iframe_group == "":
    iframe_group = str(get_instance_id())
  
  collision_layer = 0
  
  if shape:
    shape.queue_free()
    shape = null
    
  shape = CollisionShape2D.new()
  shape.shape = custom_shape

  add_child(shape)

signal hit(what: Hurtbox)

func _process(_delta: float) -> void:
  collision_mask = team
  
  if shape:
    shape.shape = custom_shape
  
  for i: Hurtbox in get_overlapping_areas():
    if i.active and (not iframe_group in i.iframes or i.iframes[iframe_group] <= 0):
      i.hit(self)
      hit.emit(i)
