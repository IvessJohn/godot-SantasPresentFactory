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


func get_type_in_string(_type: int = type) -> String:
	match _type:
		OBJECT_TYPES.PROP:
			return "Prop"
		OBJECT_TYPES.TILE:
			return "Tile"
		OBJECT_TYPES.ACTOR:
			return "NPC"
		OBJECT_TYPES.DECORATION:
			return "Decoration"
		OBJECT_TYPES.BUILDING:
			return "Building"
		_:
			return "Undefined"
