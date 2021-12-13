tool
extends Button
class_name TileButton

export(Resource) var tile_resource: Resource setget set_tile_resource


func _ready():
	rect_min_size = Vector2(16, 20)

func set_tile_resource(value: Resource):
	if tile_resource != value:
		tile_resource = value
		icon = tile_resource.ui_icon
#		text = tile_resource.name
	elif value == null:
		tile_resource = value
		icon = null
