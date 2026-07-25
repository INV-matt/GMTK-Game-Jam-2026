extends Control

const WAVE_TEXT: String = "Wave: %s"
const ENEMY_TEXT: String = "Enemies left: %s/%s"
const KILLS_TEXT: String = "Enemy kills: %s/%s"

@onready var txt_waves: Label = %wave_counter
@onready var txt_enemy: Label = %enemy_counter
@onready var txt_kills: Label = %kills_needed

func _ready() -> void:
  Signals.started_wave.connect(update_waves)
  Signals.enemy_change.connect(update_enemy)
  Signals.kills_update.connect(update_kills)

func update_waves(wave: int) -> void:
  txt_waves.text = WAVE_TEXT % wave

func update_enemy(left: int, tot: int) -> void:
  txt_enemy.text = ENEMY_TEXT % [left, tot]

func update_kills(got: int, needed: int):
  txt_kills.text = KILLS_TEXT % [got, needed]
