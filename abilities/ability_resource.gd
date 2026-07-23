extends Resource
class_name AbilityResource
#base class for all abilities. Each ability should have its own effect inside it

@export var ability_name: String
@export_multiline var description: String
@export var icon: Texture2D

#implement this function in its children
func apply_effect() -> void: pass
