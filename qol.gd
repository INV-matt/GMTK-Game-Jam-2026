extends Node

func _ready() -> void:
  plantable = [
    load("uid://cuqqq0wjip7ww"),
    load("uid://cny6rblyix2du"),
    load("uid://lxyvloc2urdi")
  ]
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
  get_tree().get_root().add_child.call_deferred(node)

func pause_game() -> void:
  get_tree().paused = true
  
func unpause_game() -> void:
  get_tree().paused = false

func tree_root() -> Window:
  return get_tree().get_root()

var player: Player

func _process(_delta: float) -> void:
  if !player: player = find_with_criteria(tree_root(), func(x: Node): return x is Player)

var plantable: Array[PlantResource] = []
