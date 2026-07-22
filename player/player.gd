extends CharacterBody2D
class_name Player

@export var SPEED = 300.0
@export var hp_comp: HpComp

func _ready() -> void:
  hp_comp.hurt.connect(on_hit)

func _physics_process(delta: float) -> void:
  var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
  
  velocity = direction * SPEED

  move_and_slide()


func on_hit(amt: float) -> void:
  print("Hit, health remaining: ", hp_comp.hp)
