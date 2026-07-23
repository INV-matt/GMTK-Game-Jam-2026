extends Control

const WAVE_TEXT: String = "Wave: %s"
const ENEMY_TEXT: String = "Enemies left: %s/%s"

@onready var txt_waves: Label = %wave_counter
@onready var txt_enemy: Label = %enemy_counter

func _ready() -> void:
  visible = false
  Signals.start_game.connect(on_start)
  Signals.started_wave.connect(update_waves)
  Signals.enemy_change.connect(update_enemy)

func on_start() -> void:
  visible = true

func update_waves(wave: int) -> void:
  txt_waves.text = WAVE_TEXT % wave

func update_enemy(left: int, tot: int) -> void:
  txt_enemy.text = ENEMY_TEXT % [left, tot]
  print(left, tot)
