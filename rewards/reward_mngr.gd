extends Control
class_name RewardMngr

var rewards_to_give: int = 0

func _ready() -> void:
  Signals.ended_wave.connect(func(wave: int):
    if wave % 3 == 0:
      show_rewards()
      rewards_to_give += 1
  )

func show_rewards():
  print("rewards")
  Qol.pause_game()
  
  
