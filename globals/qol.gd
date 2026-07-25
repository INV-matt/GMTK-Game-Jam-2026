extends Node

func _ready() -> void:
  process_mode = Node.PROCESS_MODE_ALWAYS

const MAIN_THEME = preload("uid://do3colsru7pqn")

func find_with_criteria(from: Node, criteria: Callable) -> Node:
  if criteria.call(from):
    return from

  for i: Node in from.get_children():
    var r: Node = find_with_criteria(i, criteria)

    if r:
      return r

  return null

func find_hp_comp(from: Node) -> Node:
  return find_with_criteria(from, func(x: Node) -> bool:
    return x is HpComp
  )

func create_timer(time: float, timeout: Callable) -> Timer:
  if time <= 0.0:
    timeout.call()
    return

  var t: Timer = Timer.new()
  t.autostart = true
  t.wait_time = time

  get_tree().get_root().add_child.call_deferred(t)

  t.timeout.connect(func() -> void:
    t.queue_free()
    timeout.call()
  )

  return t

func add_to_tree(node: Node) -> void:
  level_mngr.get_child(0).add_child.call_deferred(node)

func pause_game() -> void:
  get_tree().paused = true

func unpause_game() -> void:
  get_tree().paused = false

func tree_root() -> Window:
  return get_tree().get_root()

var player: Player
var wave_mngr: WaveMngr
var seed_mngr: SeedMngr
var game_mngr: GameMngr
var level_mngr: LevelMngr

func _process(_delta: float) -> void:
  if !player: player = find_with_criteria(tree_root(), func(x: Node): return x is Player)
  if !wave_mngr: wave_mngr = find_with_criteria(tree_root(), func(x: Node): return x is WaveMngr)
  if !seed_mngr: seed_mngr = find_with_criteria(tree_root(), func(x: Node): return x is SeedMngr)
  if !game_mngr: game_mngr = find_with_criteria(tree_root(), func(x: Node): return x is GameMngr)
  if !level_mngr: level_mngr = find_with_criteria(tree_root(), func(x: Node): return x is LevelMngr)

class AtlasConversion:
  var atlas: Texture2D
  var region: Rect2
  var result: ImageTexture

var conversion_cache: Array[AtlasConversion] = []

func atlas_to_texture(atlas: AtlasTexture) -> ImageTexture:
  for i in conversion_cache:
    if i.atlas == atlas.atlas and i.region == atlas.region:
      return i.result
  
  print("Converting atlas %s to image texture" % atlas)
  
  var height: int = int(atlas.get_height())
  var width: int = int(atlas.get_width())
  
  var new_tex: Image = Image.create_empty(width, height, false, Image.FORMAT_BPTC_RGBA)
  new_tex.decompress()
  
  print(width, " ", height)
  
  var atlas_img: Image = atlas.atlas.get_image()
  
  var max_height: int = int(atlas_img.get_height())
  var max_width: int = int(atlas_img.get_width())
  
  for x in range(width):
    for y in range(height):
      var px: int = x + int(atlas.region.position.x)
      var py: int = y + int(atlas.region.position.y)
      
      if px < max_width and py < max_height:
        new_tex.set_pixel(x,y, atlas.atlas.get_image().get_pixel(px,py))
  
  var img: ImageTexture = ImageTexture.create_from_image(new_tex)

  var conv: AtlasConversion = AtlasConversion.new()
  conv.atlas = atlas.atlas
  conv.region = atlas.region
  conv.result = img
  
  conversion_cache.append(conv)

  return img
