extends Node

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
  process_mode = Node.PROCESS_MODE_ALWAYS

  Signals.enemy_died.connect(func(): enemies_killed += 1)
  Signals.damage_dealt.connect(func(amt: int): damage_dealt += amt)
  Signals.damage_recieved.connect(func(amt: int): damage_recieved += amt)
  Signals.reward_selected.connect(func(_x: Reward): rewards_taken += 1)
  Signals.killed_enough_enemies.connect(func(): upgrades_taken += 1)
  Signals.started_wave.connect(func(num: int, _max_waves: int): waves_survived = num - 1)
