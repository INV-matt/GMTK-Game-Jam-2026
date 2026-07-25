extends ColorRect
class_name RewardDisplay

@onready var reward_name: RichTextLabel = %reward_name
@onready var reward_icon: TextureRect = %reward_icon
@onready var reward_description: RichTextLabel = %reward_description

@export var reward: Reward

func _ready() -> void:
  reward_name.text = reward.name
  reward_description.text = reward.description
  reward_icon.texture = reward.icon

func _on_button_pressed() -> void:
  Signals.reward_selected.emit(reward)
