tool
extends GridContainer
class_name ObjectGrid

# GameBoard will receive this node's 'object_chosen' signal to access the chosen object and be able to
# place it on the map. Every TileButton will connect its 'tile_chosen' signal to the list's
# 'object_chosen' signal
signal object_chosen(object_resource)


export(Array, Resource) var object_resources: Array = [] setget set_object_resources

var shown_children := []


func _ready():
	if not is_in_group("ObjectGrid"):
		add_to_group("ObjectGrid")
	
	if object_resources.size() > 0:
		choose_tile(object_resources[0])

func set_object_resources(value):
	if object_resources != value:
		for c in get_children():
			remove_child(c)
			if c.is_connected("object_chosen", self, "_on_objectButton_object_chosen"):
				c.disconnect("object_chosen", self, "_on_objectButton_object_chosen")
			c.queue_free()
		
		object_resources = value
		var x := 1
		for ob in object_resources:
			var button: ObjectButton = ObjectButton.new()
			button.name = "ObjectButton" + str(x)
			button.object_resource = ob
			button.connect("object_chosen", self, "_on_objectButton_object_chosen")
			add_child(button)
			
			x+=1

func _on_objectButton_object_chosen(object_resource: PlaceableObjectResource):
	choose_tile(object_resource)

func choose_tile(object_resource: PlaceableObjectResource):
	emit_signal("object_chosen", object_resource)
