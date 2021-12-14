extends YSort
class_name GameBoard

const DIRECTIONS = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]

export(Resource) var grid: Resource = preload("res://source/resources/Grid.tres")
export(Resource) var props_res: Resource  = preload("res://source/resources/PropIDResource.tres")

# Each key-value pair represents an object. The key is the position, the value is the reference to
# the object
var _objects := {}

var _selected_resource: Resource = null setget set_selected_resource

onready var _placement_overlay
onready var tilemap := $TileMap
onready var objects := $Objects


func get_unoccupied_cells() -> Array:
	var cells := []
	
	#...
	
	return cells

func get_occupied_cells(category: String = "all") -> Array:
	var cells := []
	
	match category:
		"all":
			pass
	
	return cells

# Returns an array of cells matching the parameter/category
func _flood_fill(category: String) -> Array:
	var cells := []
	
	match category:
		"unoccupied":
			pass
		"occupied":
			pass
	
	return cells

func place_object(cell: Vector2):
	# Place tile
	# tilemap.set_cellv(...)
	# tilemap.update_bitmask_region()
#	var object_scene: PackedScene = props_res.get_prop(prop_id)
	if can_place_object(cell, _selected_resource):
		match _selected_resource.type:
			PlaceableObjectResource.OBJECT_TYPES.PROP:
				# First, check if there was any other object placed and if so, remove it
				if _objects.has(cell):
					_objects[cell].queue_free()
					_objects.erase(cell)
				
				var object_scene: PackedScene = _selected_resource.scene
				var object_instance: Node2D = object_scene.instance()
				objects.add_child(object_instance)
				print((cell))
				var object_pos: Vector2 = grid.calculate_map_position(cell)
				object_instance.global_position = object_pos
				_objects[cell] = object_instance

func remove_object(cell: Vector2):
	if _objects.has(cell):
		var removed_object: Node2D = _objects[cell]
		removed_object.queue_free()
		_objects.erase(cell)

func can_place_object(cell, object_resource) -> bool:
	if not object_resource or not object_resource.scene:
		return false
	
	match object_resource.type:
		PlaceableObjectResource.OBJECT_TYPES.PROP:
			return true
		PlaceableObjectResource.OBJECT_TYPES.ACTOR:
			return not _objects.has(cell)
		PlaceableObjectResource.OBJECT_TYPES.BUILDING:
			return false
		_:
			return false

func _on_Cursor_moved(new_cell):
	pass

func _on_Cursor_accept_pressed(cell):
	place_object(cell)

func _on_Cursor_accept_removed(cell):
	remove_object(cell)

func set_selected_resource(value):
	if _selected_resource != value:
		_selected_resource = value
		print("_selected_resource = " + str(_selected_resource))
