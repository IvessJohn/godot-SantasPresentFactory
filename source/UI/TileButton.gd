tool
extends Button
class_name ObjectButton

signal object_chosen(object_resource)


export(Resource) var object_resource: Resource setget set_object_resource


func _ready():
	rect_min_size = Vector2(24, 24)
	expand_icon = true
	# Will emit the signal 'object_chosen' when pressed
	connect("pressed", self, "on_pressed")
	
	if not is_in_group("ObjectButton"):
		add_to_group("ObjectButton")
	
	if object_resource:
		hint_tooltip = object_resource.name + "\r\n" + object_resource.get_type_in_string() 

func set_object_resource(value: Resource):
	if object_resource != value:
		object_resource = value
		icon = object_resource.ui_icon
#		text = object_resource.name
	elif value == null:
		object_resource = value
		icon = null

# Emits the signal 'object_chosen', so respective nodes can have the access to the new chosen object
func on_pressed():
	emit_signal("object_chosen", object_resource)
