extends Node

@warning_ignore("unused_signal")
signal spawned_enemy(pos: Vector2)

@warning_ignore("unused_signal")
signal started_wave(wave: int)

@warning_ignore("unused_signal")
signal start_game()

@warning_ignore("unused_signal")
signal open_options()

@warning_ignore("unused_signal")
signal close_options()

@warning_ignore("unused_signal")
signal enemy_change(alive: int, total_in_wave: int)
@warning_ignore("unused_signal")
signal enemy_died()
