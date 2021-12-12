extends YSort
class_name GameBoard

const DIRECTIONS = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]

export(Resource) var grid: Resource = preload("res://source/resources/Grid.gd")

# Each key-value pair represents an object. The key is the position, the value is the reference to
# the object
var _objects := {}


onready var _placement_overlay


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
