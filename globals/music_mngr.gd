extends Node

var tracks: Dictionary[String, AudioStreamOggVorbis] = {
  "chill": preload("uid://cyevilxiude1r"),
  "battle": preload("uid://c1nfv8y7g4833"),
  "menu": preload("uid://bf7b8b3f0bn7h"),
}

var playing: String = ""

var players: Dictionary[String, AudioStreamPlayer] = {}

func _ready() -> void:
  process_mode = Node.PROCESS_MODE_ALWAYS

  for i in tracks:
    var player: AudioStreamPlayer = AudioStreamPlayer.new()
    player.stream = tracks[i]
    player.autoplay = true
    player.volume_linear = 0.0
    
    add_child(player)
    
    players[i] = player
  
  play_track("menu")

func _process(_delta: float) -> void:
  for i in players:
    players[i].volume_linear = players[i].volume_linear * .9 + (1.0 if i == playing else 0.0) * .1

func play_track(track: String) -> void:
  if not track in tracks:
    push_error("No track names '%s', possible tracks are: %s" % [track, tracks.keys()])
    return
  
  playing = track
