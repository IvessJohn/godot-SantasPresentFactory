tool
extends TabContainer
class_name ObjectSelectionTabContainer

# GameBoard will receive this node's 'tile_chosen' signal to access the chosen tile and be able to
# place it on the map. Every TileButton will connect its 'tile_chosen' signal to the list's
# 'tile_chosen' signal
signal object_chosen(object_resource)


export(Array, Resource) var object_resources: Array = [] setget set_object_resources

var objectGrids := {
	"props": $Props/ScrollContainer/TileGrid,
	"actors": $Actors/ScrollContainer/TileGrid
}

var shown_children := []


func _ready():
	if not is_in_group("ObjectSelectionTabContainer"):
		add_to_group("ObjectSelectionTabContainer")
	
	if object_resources.size() > 0:
		choose_object(object_resources[0])

func set_object_resources(value):
	if object_resources != value:
		for k in objectGrids.keys():
			for c in objectGrids[k].get_children():
				remove_child(c)
				if c.is_connected("object_chosen", self, "_on_tileButton_tile_chosen"):
					c.disconnect("object_chosen", self, "_on_tileButton_tile_chosen")
				c.queue_free()
		
		object_resources = value
		var x := 1
		for o in object_resources:
			var button: TileButton = TileButton.new()
			button.name = "TileButton" + str(x)
			button. = o
			button.connect("tile_chosen", self, "_on_tileButton_tile_chosen")
			
			var parent_grid: GridContainer = _get_respective_grid_for(o)
			parent_grid.add_child(button)
			
			x+=1

func _on_tileButton_object_chosen(object_resource: PlaceableObjectResource):
	choose_object(object_resource)

func choose_object(object_resource: PlaceableObjectResource):
	emit_signal("object_chosen", object_resource)

func _get_respective_grid_for(object_resource: PlaceableObjectResource):
	match object_resource.type:
		PlaceableObjectResource.OBJECT_TYPES.PROP, \
		PlaceableObjectResource.OBJECT_TYPES.TILE, \
		PlaceableObjectResource.OBJECT_TYPES.DECORATION:
			return objectGrids["props"]
		PlaceableObjectResource.OBJECT_TYPES.ACTOR:
			return objectGrids["actors"]
