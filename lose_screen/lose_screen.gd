extends Control

@onready var anim: AnimationPlayer = %anim
@onready var stat_holder: VBoxContainer = %stat_holder

var enemies_killed: int = 0
var damage_dealt: int = 0
var damage_recieved: int = 0
var rewards_taken: int = 0
var upgrades_taken: int = 0
var waves_survived: int = 0

var total_score: int = 0:
  get():
    return  enemies_killed * 20 + \
            damage_dealt * 5 + \
            damage_recieved * -10 + \
            rewards_taken * -5 + \
            upgrades_taken * -1 + \
            waves_survived * 20

func _ready() -> void:
  visible = false
  anim.play("RESET")
  
  Signals.all_plants_died.connect(show_lose_screen)
  
  Signals.enemy_died.connect(func(): enemies_killed += 1)
  Signals.damage_dealt.connect(func(amt: int): damage_dealt += amt)
  Signals.damage_recieved.connect(func(amt: int): damage_recieved += amt)
  Signals.reward_selected.connect(func(_x: Reward): rewards_taken += 1)
  Signals.killed_enough_enemies.connect(func(): upgrades_taken += 1)
  Signals.started_wave.connect(func(num: int): waves_survived = num - 1)

func show_lose_screen():
  Qol.pause_game()
  visible = true
  anim.play("you died")

func add_stat(stat_name: String):
  var r: RichTextLabel = RichTextLabel.new()
  r.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
  r.fit_content = true
  r.text = "%s: %s" % [stat_name.capitalize(), self[stat_name.replace(" ", "_")]]
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
