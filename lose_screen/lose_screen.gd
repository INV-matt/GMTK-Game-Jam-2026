extends Control

@onready var anim: AnimationPlayer = %anim

func _ready() -> void:
  visible = false
  Signals.all_plants_died.connect(show_lose_screen)
  anim.play("RESET")

func show_lose_screen():
  Qol.pause_game()
  visible = true
  anim.play("you died")
