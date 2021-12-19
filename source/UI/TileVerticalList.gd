tool
extends GridContainer
class_name ObjectGrid

# GameBoard will receive this node's 'tile_chosen' signal to access the chosen tile and be able to
# place it on the map. Every TileButton will connect its 'tile_chosen' signal to the list's
# 'tile_chosen' signal
signal tile_chosen(tile_resource)


export(Array, Resource) var tile_resources: Array = [] setget set_tile_resources

var shown_children := []


func _ready():
	if not is_in_group("ObjectGrid"):
		add_to_group("ObjectGrid")
	
	if tile_resources.size() > 0:
		choose_tile(tile_resources[0])

func set_tile_resources(value):
	if tile_resources != value:
		for c in get_children():
			remove_child(c)
			if c.is_connected("tile_chosen", self, "_on_tileButton_tile_chosen"):
				c.disconnect("tile_chosen", self, "_on_tileButton_tile_chosen")
			c.queue_free()
		
		tile_resources = value
		var x := 1
		for t in tile_resources:
			var button: TileButton = TileButton.new()
			button.name = "TileButton" + str(x)
			button.tile_resource = t
			button.connect("tile_chosen", self, "_on_tileButton_tile_chosen")
			add_child(button)
			
			x+=1

func _on_tileButton_tile_chosen(tile_resource: PlaceableObjectResource):
	choose_tile(tile_resource)

func choose_tile(tile_resource: PlaceableObjectResource):
	emit_signal("tile_chosen")
