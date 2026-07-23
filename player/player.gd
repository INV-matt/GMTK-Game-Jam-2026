extends CharacterBody2D
class_name Player

@export var SPEED = 300.0

@warning_ignore("unused_signal")
signal ability_list_changed

@export var abilities: Array[Ability]
@export var primary_ability_idx: int = 0
@export var secondary_ability_idx: int = 1
@export var tertiary_ability_idx: int = 2

@onready var hp_comp: HpComp = %HpComp
@onready var death_timer: Timer = %DeathTimer
@onready var sprite: AnimatedSprite2D = %sprite

var is_dead: bool = false

func _ready() -> void:
  hp_comp.hurt.connect(on_hit)
  hp_comp.died.connect(on_death)
  hp_comp.healed.connect(on_heal)
  death_timer.timeout.connect(handle_respawn)

func _physics_process(delta: float) -> void:
  if is_dead: return
  var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
  velocity = direction * SPEED * delta * 60

  move_and_slide()

func on_heal(amt: float) -> void:
  print("Healed %s, health remaining: %s" % [-amt, hp_comp.hp])

func on_hit(amt: float) -> void:
  #if is_dead: return
  print("Hit %s, health remaining: %s" % [amt, hp_comp.hp])

func on_death() -> void:
  if is_dead: return
  print("You died")
  is_dead = true
  hp_comp.disabled = true
  death_timer.start()

func handle_respawn() -> void:
  print("Respawning")
  is_dead = false
  hp_comp.disabled = false
  hp_comp.full_heal()
  global_position = Vector2(0, 0) # TODO: make it spawn in its original spawn point, not on the greenhouse

func _process(_delta: float) -> void:
  # ts is disgusting
  if len(abilities) > primary_ability_idx and Input.is_action_pressed("primary"):
    abilities[primary_ability_idx].use_ability(self, get_global_mouse_position())
  if len(abilities) > secondary_ability_idx and Input.is_action_pressed("secondary"):
    abilities[secondary_ability_idx].use_ability(self, get_global_mouse_position())
  if len(abilities) > tertiary_ability_idx and Input.is_action_pressed("tertiary"):
    abilities[tertiary_ability_idx].use_ability(self, get_global_mouse_position())
