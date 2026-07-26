extends Node

const SAVE_PATH: String = "user://savegame.save"

var save: Savefile = Savefile.new()

var highscore: int = 0:
  get():
    if Globals.difficulty_mult == .5: return save.highscore_easy
    
    if Globals.difficulty_mult == 1: return save.highscore_normal
    
    return save.highscore_easy
  set(value):
    if value < highscore: return
    
    if Globals.difficulty_mult == .5: save.highscore_easy = value
    elif Globals.difficulty_mult == 1: save.highscore_normal = value
    elif Globals.difficulty_mult == 3: save.highscore_hard = value
    
    save_savefile()

func _ready() -> void:
  process_mode = Node.PROCESS_MODE_ALWAYS
  load_savefile()
  
func load_savefile():
  if !FileAccess.file_exists(SAVE_PATH):
    save_savefile()
    load_savefile()
    return
  
  var raw_file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
  
  var json: JSON = JSON.new()
  
  var parse_result = json.parse(raw_file.get_as_text())
  if parse_result != OK:
    print("JSON parser error")
    return
  
  var parsed_file = json.data
  
  save.highscore_easy = parsed_file.highscore_easy
  save.highscore_normal = parsed_file.highscore_normal
  save.highscore_hard = parsed_file.highscore_hard
  
  print("Highscores:")
  print(" Easy   ", save.highscore_easy)
  print(" Normal ", save.highscore_normal)
  print(" Hard   ", save.highscore_hard)

func save_savefile():
  var write_file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
  
  write_file.store_string(JSON.stringify({
    "highscore_easy": save.highscore_easy,
    "highscore_normal": save.highscore_normal,
    "highscore_hard": save.highscore_hard,
  }))
