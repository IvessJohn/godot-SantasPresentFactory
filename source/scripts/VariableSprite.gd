extends Sprite
class_name VariableSprite

export(Array, Texture) var TEXTURE_VARIATIONS_ARRAY: Array = []

func _ready():
	variate_texture()

func variate_texture():
	pass
	# Separate files approach
	if TEXTURE_VARIATIONS_ARRAY.size() > 1:
		var texture_id: int = randi() % TEXTURE_VARIATIONS_ARRAY.size()
		var chosen_texture: Texture = TEXTURE_VARIATIONS_ARRAY[texture_id]
		texture = chosen_texture
