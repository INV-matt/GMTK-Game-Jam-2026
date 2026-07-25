extends Control
class_name RewardMngr

const REWARD_DISPLAY = preload("uid://bwbuwmt7em805")
const REWARD_NUM: int = 3

@onready var rewards: HBoxContainer = %rewards
@onready var reward_num: RichTextLabel = %reward_num

@export var possible_rewards: Array[Reward] = []

var rewards_to_give: int = 0:
  set(value):
    reward_num.text = "Rewards left: %s" % value
    rewards_to_give = value

func _ready() -> void:
  visible = false
  Signals.ended_wave.connect(func(wave: int):
    if wave % 3 == 0:
      show_rewards()
      rewards_to_give += 1
  )
  Signals.reward_selected.connect(reward_selected)

func show_rewards():
  print("rewards")
  Qol.pause_game()
  if !showing_rewards:
    pick_rewards()
  showing_rewards = true
  visible = true

var showing_rewards: bool = false

func pick_rewards():
  var already_picked: Array[Reward] = []
  
  for i in range(REWARD_NUM):
    if len(already_picked) >= len(possible_rewards): break
    
    var r: Reward = possible_rewards.filter(func(x: Reward): return !x in already_picked).pick_random()

    already_picked.append(r)
    
    var disp: RewardDisplay = REWARD_DISPLAY.instantiate()
    disp.reward = r
    
    rewards.add_child(disp)

func reward_selected(reward: Reward):
  reward.give_reward()
  print(reward.name)
  
  for i in rewards.get_children():
    i.queue_free()
  
  rewards_to_give -= 1
  
  if rewards_to_give > 0:
    pick_rewards()
  else:
    Qol.unpause_game()
    visible = false
    showing_rewards = false
