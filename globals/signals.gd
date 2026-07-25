extends Node

@warning_ignore_start("unused_signal")

## Wave Manager Signals
signal spawned_enemy(pos: Vector2)
signal started_wave(wave: int, max_waves: int)
signal ended_wave(wave: int)
signal last_wave
signal all_waves_finished
signal kills_update(got: int, needed: int)
signal wave_timer_update(time: float)
signal enemy_change(alive: int, total_in_wave: int)
signal enemy_died()

## Menu Signals
signal start_game()
signal open_options()
signal close_options()

## Upgrade signals
signal open_upgrades()
signal close_upgrades()
signal stats_change()
signal upgrade_ui_closed()
signal killed_enough_enemies()

## Rewards signals
signal rewards_opened()
signal rewards_closed()
signal reward_selected(reward: Reward)

## Misc signals
signal all_plants_died
signal waves_finished
signal damage_dealt(amt: int)
signal damage_recieved(amt: int)

@warning_ignore_restore("unused_signal")
