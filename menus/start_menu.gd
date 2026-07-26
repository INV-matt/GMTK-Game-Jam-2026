extends CanvasLayer

@onready var btn_start: Button = %start
@onready var btn_options: Button = %options
@onready var btn_quit: Button = %quit
@onready var difficulty: VBoxContainer = %difficulty
@onready var easy: Button = %easy
@onready var normal: Button = %normal
@onready var hard: Button = %hard
@onready var anim: AnimationPlayer = %anim

func _ready():
  btn_start.pressed.connect(on_start)
  btn_options.pressed.connect(on_options)
  btn_quit.pressed.connect(on_quit)
  easy.pressed.connect(start_easy)
  normal.pressed.connect(start_normal)
  hard.pressed.connect(start_hard)

  if OS.has_feature("web"):
    btn_quit.visible = false

var opened: bool = false

func on_start() -> void:
  if !opened:
    anim.play("open_difficulty")
  else:
    anim.play_backwards("open_difficulty")
  
  opened = !opened

func start_easy():
  Globals.difficulty_mult = 0.5
  start_game()
func start_normal():
  Globals.difficulty_mult = 1.0
  start_game()
func start_hard():
  Globals.difficulty_mult = 3.0
  start_game()

func start_game():
  Signals.start_game.emit()
  visible = false

func on_options() -> void:
  Signals.open_options.emit()

func on_quit() -> void:
  get_tree().quit()
