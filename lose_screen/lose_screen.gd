extends Control

const CUSTOM_NUM = preload("uid://b71khpxy8nflg")
const MAIN_SCENE = preload("uid://ty0tblji2he1")

@onready var anim: AnimationPlayer = %anim
@onready var stat_holder: VBoxContainer = %stat_holder
@onready var success_label: RichTextLabel = %success_label
@onready var winjingle: AudioStreamPlayer = %winjingle
@onready var losejungle: AudioStreamPlayer = %losejungle
@onready var pg_stats: RichTextLabel = %pg_stats
@onready var trophy: TextureRect = %trophy

@export var stat_icons: Dictionary[String, Texture2D] = {}

func _ready() -> void:
  trophy.visible = false
  visible = false
  anim.play("RESET")
  
  Signals.all_plants_died.connect(show_lose_screen)
  Signals.all_waves_finished.connect(show_win_screen)
  (%btn_main_menu as Button).pressed.connect(return_to_menu)
  
func return_to_menu():
  Qol.unpause_game()
  get_tree().reload_current_scene()

func show_lose_screen():
  Qol.pause_game()
  visible = true
  anim.play("you died")
  success_label.text = "THE GARDEN WAS DESTROYED"
  success_label.add_theme_color_override("default_color", Color.RED)
  losejungle.play()

func show_win_screen():
  Qol.pause_game()
  visible = true
  anim.play("you died")
  success_label.text = "THE ENEMIES ARE GONE"
  success_label.add_theme_color_override("default_color", Color.GREEN)
  winjingle.play()
  
  if ScoreMngr.total_score > SaveMngr.highscore:
    pg_stats.text = "Post-game stats (New Highscore!)"
    pg_stats.add_theme_color_override("default_color", Color.YELLOW)
    SaveMngr.highscore = ScoreMngr.total_score
    trophy.visible = true
  
func add_stat(stat_name: String):
  var h: HBoxContainer = HBoxContainer.new()
  
  h.size_flags_vertical = Control.SIZE_EXPAND_FILL
  
  var icon: TextureRect = TextureRect.new()
  icon.texture = stat_icons[stat_name]
  icon.offset_transform_enabled = true
  icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
  icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
  icon.size_flags_horizontal = Control.SIZE_EXPAND_FILL
  icon.offset_transform_enabled = true
  icon.offset_transform_position.x = -icon.texture.get_width()
  icon.offset_transform_position_ratio.x = 1.0
  
  h.add_child(icon)
  
  var num: CustomNum = CUSTOM_NUM.instantiate()
  num.number = ScoreMngr[stat_name.replace(" ", "_")]
  num.offset_transform_enabled = true
  num.offset_transform_position.y = 12
  num.size_flags_horizontal = Control.SIZE_EXPAND_FILL
  if stat_name == "total score":
    num.color = CustomNum.Colors.Blue
  
  h.add_child(num)
  
  #var r: RichTextLabel = RichTextLabel.new()
  #r.fit_content = true
  #r.text = "%s" % ScoreMngr[stat_name.replace(" ", "_")]
  #r.size_flags_vertical = Control.SIZE_EXPAND_FILL
  #r.size_flags_horizontal = Control.SIZE_EXPAND_FILL
  #r.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
  #
  #h.add_child(r)

  stat_holder.add_child(h)
  stat_holder.move_child(h, -3)

func display_stats():
  add_stat("enemies killed")
  add_stat("damage dealt")
  add_stat("damage recieved")
  add_stat("rewards taken")
  add_stat("upgrades taken")
  add_stat("waves survived")
  add_stat("total score")
