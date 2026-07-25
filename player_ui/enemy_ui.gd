extends Control

@onready var wave_num: CustomNum = %wave_num
@onready var enemy_num: CustomNum = %enemy_num
@onready var kill_num: CustomNum = %kill_num

@onready var wave_countdown: Label = %wave_countdown
@onready var wave_label: Label = %wave_label

func _ready() -> void:
  Signals.started_wave.connect(update_waves)
  Signals.enemy_change.connect(update_enemy)
  Signals.kills_update.connect(update_kills)
  Signals.wave_timer_update.connect(update_timer)
  Signals.last_wave.connect(last_wave)

func last_wave():
  wave_countdown.visible = false
  wave_label.text = "Last wave, good luck!"

func update_timer(time: float) -> void:
  var minutes: int = int(time / 60)
  
  if minutes > 0:
    var seconds: float = time - minutes * 60
    
    if seconds >= 10:
      wave_countdown.text = "%s:%.1f" % [minutes, time - minutes * 60]
      return
      
    wave_countdown.text = "%s:0%.1f" % [minutes, time - minutes * 60]
    return
    
  wave_countdown.text = "%.1f" % time

func update_waves(wave: int, max_waves: int) -> void:
  wave_num.number = max_waves - wave

func update_enemy(left: int, _tot: int) -> void:
  enemy_num.number = left

func update_kills(got: int, needed: int):
  kill_num.number = needed - got
