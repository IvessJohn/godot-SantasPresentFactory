tool
extends Button
class_name TileButton

signal tile_chosen(tile_resource)


export(Resource) var tile_resource: Resource setget set_tile_resource


func _ready():
	rect_min_size = Vector2(16, 20)
	# Will emit the signal 'tile_chosen' when pressed
	connect("pressed", self, "on_pressed")
	
	if not is_in_group("TileButton"):
		add_to_group("TileButton")

func set_tile_resource(value: Resource):
	if tile_resource != value:
		tile_resource = value
		icon = tile_resource.ui_icon
#		text = tile_resource.name
	elif value == null:
		tile_resource = value
		icon = null

# Emits the signal 'tile_chosen', so respective nodes can have the access to the new chosen tile
func on_pressed():
	emit_signal("tile_chosen", tile_resource)
