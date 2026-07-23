extends Area2D
class_name SeedPacket

@onready var sprite: Sprite2D = %sprite

@export var plant: PlantResource

func _ready() -> void:
  sprite.texture = plant.packet_sprite

func _on_body_entered(body: Node2D) -> void:
  Qol.seed_mngr.add_seed(plant)
  queue_free()
