@tool

extends VisibleOnScreenNotifier2D
class_name Ping

const PADDING: float = 50.0

@onready var sprite: Sprite2D = %sprite

@export var icon: Texture2D
@export var border_color: Color = Color.WHITE
@export var urgency: float = 1.0

@export_group("Onscreen Behaviour")
@export var show_onscreen: bool = true
@export var onscreen_offset: Vector2

func _ready() -> void:
  if !Engine.is_editor_hint(): visible = true
  
  sprite.material = sprite.material.duplicate()
  (sprite.material as ShaderMaterial).set_shader_parameter("ping_tex", icon)
  (sprite.material as ShaderMaterial).set_shader_parameter("border_col", border_color)
  (sprite.material as ShaderMaterial).set_shader_parameter("urgency", urgency)

# Thanks to the GOAT
# https://www.jeffreythompson.org/collision-detection/line-line.php

func lineRect(x1: float, y1: float, x2: float, y2: float, rx: float, ry: float, rw: float, rh: float) -> Vector2:
  var left:   Vector2 = lineLine(x1,y1,x2,y2, rx,ry,rx, ry+rh);
  var right:  Vector2 = lineLine(x1,y1,x2,y2, rx+rw,ry, rx+rw,ry+rh);
  var top:    Vector2 = lineLine(x1,y1,x2,y2, rx,ry, rx+rw,ry);
  var bottom: Vector2 = lineLine(x1,y1,x2,y2, rx,ry+rh, rx+rw,ry+rh);

  if left != Vector2(PI, PI): return left
  if right != Vector2(PI, PI): return right
  if top != Vector2(PI, PI): return top
  if bottom != Vector2(PI, PI): return bottom

  return Vector2(PI, PI)

func lineLine(x1: float, y1: float, x2: float, y2: float, x3: float, y3: float, x4: float, y4: float) -> Vector2:
  var uA: float = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  var uB: float = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  if uA >= 0 and uA <= 1 and uB >= 0 and uB <= 1 :
    var intersectionX: float = x1 + (uA * (x2-x1))
    var intersectionY: float = y1 + (uA * (y2-y1))

    return Vector2(intersectionX, intersectionY)
  
  return Vector2(PI, PI)

func _process(_delta: float) -> void:
  if Engine.is_editor_hint():
    (sprite.material as ShaderMaterial).set_shader_parameter("ping_tex", icon)
    (sprite.material as ShaderMaterial).set_shader_parameter("border_col", border_color)
    (sprite.material as ShaderMaterial).set_shader_parameter("urgency", urgency)
    return
  
  if !is_on_screen():
    sprite.visible = true
    
    var maincam: Camera2D = get_viewport().get_camera_2d()
    var viewport_size: Vector2 = get_viewport_rect().size
    var viewport_pos: Vector2 = maincam.global_position
    viewport_size.x /= maincam.zoom.x
    viewport_size.y /= maincam.zoom.y
    viewport_pos -= viewport_size / 2.0
    viewport_size -= Vector2(PADDING, PADDING) * 2
    viewport_pos += Vector2(PADDING, PADDING)
    
    var intersect: Vector2 = lineRect(
      global_position.x, global_position.y, 
      Qol.player.global_position.x, Qol.player.global_position.y,
      viewport_pos.x, viewport_pos.y,
      viewport_size.x, viewport_size.y
    )

    sprite.global_position = intersect
  else:
    sprite.visible = show_onscreen
    sprite.position = onscreen_offset
