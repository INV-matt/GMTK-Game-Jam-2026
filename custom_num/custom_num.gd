@tool

extends HBoxContainer
class_name CustomNum

const NUMBER_COUNTER_SHEET = preload("uid://bmofdgq0i143k")
const NUM_WIDTH: int = 18
const NUM_HEIGHT: int = 24

enum Colors {
  White = 0,
  Red = 1,
  Blue = 2
}

var actual_num: int = 0
@export var number: int = 0:
  set(value):
    number = value
@export var color: Colors = Colors.White:
  set(value):
    color = value
    update_num()

var elapsed: float = 0.0
func _process(delta: float) -> void:
  elapsed += delta
  
  if elapsed >= .1:
    elapsed -= .1
    var l: float = max(0, floor(log(abs(number - actual_num)) / log(10)))
    actual_num = int(move_toward(actual_num, number, pow(10, l)))
    update_num()

func update_num():
  for i in get_children():
    i.queue_free()
  
  for i in str(actual_num):
    var num: int = int(i)
    
    var px: int = num
    
    var tex: AtlasTexture = AtlasTexture.new()
    tex.atlas = NUMBER_COUNTER_SHEET
    tex.region = Rect2(
      px * (NUM_WIDTH + 14) + 7, color * 32 + 8,
      NUM_WIDTH, NUM_HEIGHT
    )
    
    var spr: TextureRect = TextureRect.new()
    spr.texture = tex
    spr.custom_maximum_size = Vector2(NUM_WIDTH, NUM_HEIGHT)
    spr.custom_minimum_size = Vector2(NUM_WIDTH, NUM_HEIGHT)
    spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
    
    add_child(spr)
