extends Control

const WAVE_TEXT: String = "%s"
const ENEMY_TEXT: String = "%s/%s"
const KILLS_TEXT: String = "%s/%s"

@onready var txt_waves: Label = %wave_counter
@onready var txt_enemy: Label = %enemy_counter
@onready var txt_kills: Label = %kills_needed
@onready var wave_countdown: Label = %wave_countdown

func _ready() -> void:
  Signals.started_wave.connect(update_waves)
  Signals.enemy_change.connect(update_enemy)
  Signals.kills_update.connect(update_kills)
  Signals.wave_timer_update.connect(update_timer)

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

func update_waves(wave: int) -> void:
  txt_waves.text = WAVE_TEXT % wave

func update_enemy(left: int, tot: int) -> void:
  txt_enemy.text = ENEMY_TEXT % [left, tot]

func update_kills(got: int, needed: int):
  txt_kills.text = KILLS_TEXT % [got, needed]
