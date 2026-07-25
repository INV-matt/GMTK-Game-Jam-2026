extends Area2D
class_name SeedPacket

@onready var sprite: Sprite2D = %sprite
@onready var ping: Ping = %ping

@export var plant: PlantResource

func _ready() -> void:
  sprite.texture = plant.packet_sprite
  ping.icon = plant.packet_sprite
  ping._ready()

func _on_body_entered(_body: Node2D) -> void:
  Qol.seed_mngr.add_seed(plant)
  queue_free()
