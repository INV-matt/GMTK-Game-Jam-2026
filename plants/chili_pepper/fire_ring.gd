extends Node2D
class_name FireRing

@onready var collider: DmgHitbox = %collider
@onready var particles: GPUParticles2D = %particles

@export var base_damage: float = 4
@export var tick_speed: float = 3
@export var damage_stage_increase: float = 1

var target_scale: float = 0

@export var stage = 0:
  set(value):
    stage = value

    if !is_node_ready(): return

    collider.set_deferred("disabled", false)
    particles.emitting = false

    if stage <= 0: return

    collider.active = true
    particles.emitting = true
    particles.amount_ratio = stage / 3.0
  
    target_scale = .1 + .05 * (stage - 1)
    collider.set_deferred("disabled", true)
    
    match stage:
      1:
        collider.damage = base_damage
        collider.iframe_length = 1 / tick_speed
      2:
        collider.damage = base_damage
        collider.iframe_length = 1 / (tick_speed + 1)
      3:
        collider.damage = base_damage + damage_stage_increase
        collider.iframe_length = 1 / (tick_speed + 1)
      _:
        pass

    
func _ready() -> void:
  stage = 0
  collider.active = false
  collider.iframe_length = 1 / tick_speed
  collider.damage = base_damage

func _process(_delta: float) -> void:
  collider.scale = collider.scale * .9 + Vector2(10, 5.4) * target_scale * .1
