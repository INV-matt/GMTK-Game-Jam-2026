extends Control

@onready var anim: AnimationPlayer = %anim
@onready var stat_holder: VBoxContainer = %stat_holder
@onready var success_label: RichTextLabel = %success_label

func _ready() -> void:
  visible = false
  anim.play("RESET")
  
  Signals.all_plants_died.connect(show_lose_screen)
  Signals.all_waves_finished.connect(show_win_screen)

func show_lose_screen():
  Qol.pause_game()
  visible = true
  anim.play("you died")
  success_label.text = "THE GARDEN WAS DESTROYED"
  success_label.add_theme_color_override("default_color", Color.RED)

func show_win_screen():
  Qol.pause_game()
  visible = true
  anim.play("you died")
  success_label.text = "THE ENEMIES ARE GONE"
  success_label.add_theme_color_override("default_color", Color.GREEN)
  
func add_stat(stat_name: String):
  var r: RichTextLabel = RichTextLabel.new()
  r.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
  r.fit_content = true
  r.text = "%s: %s" % [stat_name.capitalize(), ScoreMngr[stat_name.replace(" ", "_")]]
  r.size_flags_vertical = Control.SIZE_EXPAND_FILL
  r.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

  stat_holder.add_child(r)

func display_stats():
  add_stat("enemies killed")
  add_stat("damage dealt")
  add_stat("damage recieved")
  add_stat("rewards taken")
  add_stat("upgrades taken")
  add_stat("waves survived")
  add_stat("total score")
