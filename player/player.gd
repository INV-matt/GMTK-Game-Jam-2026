extends CharacterBody2D
class_name Player

@export var SPEED = 300.0

@warning_ignore("unused_signal")
signal ability_list_changed

@export var starting_ability: Ability

@export var abilities: Array[Ability]
@export var primary_ability_idx: int = 0
@export var secondary_ability_idx: int = 1
@export var tertiary_ability_idx: int = 2

@onready var hp_comp: HpComp = %HpComp
@onready var death_timer: Timer = %DeathTimer
@onready var sprite: AnimatedSprite2D = %sprite
@onready var footsteps: AudioStreamPlayer2D = %footsteps

var is_dead: bool = false

func _ready() -> void:
  hp_comp.died.connect(on_death)
  death_timer.timeout.connect(handle_respawn)

var last_move_dir: Vector2

func _physics_process(delta: float) -> void:
  if is_dead: return
  var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
  velocity = direction * SPEED * delta * 60 * Globals.PLAYER_SPEED_MULTIPLIER
  
  if direction:
    last_move_dir = direction.normalized()

  move_and_slide()

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

var directions: Dictionary[String, Vector2] = {
  "up": Vector2(0, -1),
  "down": Vector2(0, 1),
  "left": Vector2(-1, 0),
  "right": Vector2(1, 0)
}

func _process(_delta: float) -> void:
  if Qol.wave_mngr.current_wave > 0:
    var offense: Array[Ability] = abilities.filter(func(x: Ability): return x.is_offensive)
    
    if len(offense) == 0:
      abilities.insert(0, starting_ability)
      ability_list_changed.emit()
    if len(offense) > 1 and starting_ability in abilities:
      abilities.erase(starting_ability)
      ability_list_changed.emit()
  
  # ts is disgusting
  if len(abilities) > primary_ability_idx and Input.is_action_pressed("primary"):
    abilities[primary_ability_idx].use_ability(self, get_global_mouse_position())
  if len(abilities) > secondary_ability_idx and Input.is_action_pressed("secondary"):
    abilities[secondary_ability_idx].use_ability(self, get_global_mouse_position())
  if len(abilities) > tertiary_ability_idx and Input.is_action_pressed("tertiary"):
    abilities[tertiary_ability_idx].use_ability(self, get_global_mouse_position())

  var dir: String = ""
  var max_dot: float = -1.0
  
  for i in directions:
    var d: float = last_move_dir.dot(directions[i])
    
    if d > max_dot:
      max_dot = d
      dir = i
  
  var anim_name: String = "walk" if velocity else "idle" 
  
  if dir == "left":
    sprite.flip_h = true
    sprite.play("%s_right" % anim_name)
  elif dir == "right":
    sprite.flip_h = false
    sprite.play("%s_right" % anim_name)
  else:
    sprite.play("%s_%s" % [anim_name, dir])

  var to_play: bool = velocity != Vector2.ZERO
  if footsteps.playing != to_play:
    footsteps.playing = to_play
