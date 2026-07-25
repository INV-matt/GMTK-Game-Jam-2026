extends Node

@warning_ignore_start("unused_signal")

signal spawned_enemy(pos: Vector2)
signal started_wave(wave: int)
signal ended_wave()
signal start_game()
signal open_options()
signal close_options()
signal open_upgrades()
signal close_upgrades()
signal enemy_change(alive: int, total_in_wave: int)
signal enemy_died()
signal stats_change()
signal upgrade_ui_closed()
signal killed_enough_enemies()
signal kills_update(got: int, needed: int)

@warning_ignore_restore("unused_signal")
