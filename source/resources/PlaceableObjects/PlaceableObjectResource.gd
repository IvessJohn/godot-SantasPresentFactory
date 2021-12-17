extends Resource
class_name PlaceableObjectResource

enum OBJECT_TYPES {
	PROP,
	ACTOR,
	TILE,
	BUILDING,
	DECORATION	# Decorations are walkable, props aren't
}

export(String) var name: String
export(OBJECT_TYPES) var type := OBJECT_TYPES.PROP
export(Texture) var ui_icon: Texture
export(Texture) var texture: Texture
export(PackedScene) var scene: PackedScene
