extends CanvasLayer

@onready var btn_start: Button = %start
@onready var btn_options: Button = %options
@onready var btn_quit: Button = %quit
@onready var difficulty: VBoxContainer = %difficulty
@onready var easy: Button = %easy
@onready var normal: Button = %normal
@onready var hard: Button = %hard
@onready var anim: AnimationPlayer = %anim
@onready var high_easy: RichTextLabel = %high_easy
@onready var high_normal: RichTextLabel = %high_normal
@onready var high_hard: RichTextLabel = %high_hard

func _ready():  
  btn_start.pressed.connect(on_start)
  btn_options.pressed.connect(on_options)
  btn_quit.pressed.connect(on_quit)
  easy.pressed.connect(start_easy)
  normal.pressed.connect(start_normal)
  hard.pressed.connect(start_hard)
  Signals.return_to_main_menu.connect(on_return_to_main_menu)

  if OS.has_feature("web"):
    btn_quit.visible = false

  await get_tree().process_frame
  
  high_easy.text = "Easy - %s" % SaveMngr.save.highscore_easy
  high_normal.text = "Normal - %s" % SaveMngr.save.highscore_normal
  high_hard.text = "Hard - %s" % SaveMngr.save.highscore_hard

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

func on_return_to_main_menu() -> void:
  visible = true
  Qol.unpause_game()
