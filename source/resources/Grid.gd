extends Resource

export var size := Vector2(16, 16)
export var cell_size := Vector2(16, 16)

var half_cell_size := cell_size * 0.5


func calculate_map_position(grid_position: Vector2) -> Vector2:
	return grid_position * cell_size + half_cell_size

func calculate_grid_position(map_position: Vector2) -> Vector2:
	return (map_position / cell_size).floor()


# Returns true if `cell_coordinates` are withing the grid
#
# Note: cell_coordinates must be given like grid coordinates, not world coordinates
func is_within_grid_boundaries(cell_coordinates: Vector2) -> bool:
	var within_x := (cell_coordinates.x >= 0 and cell_coordinates.x < size.x)
	var within_y := (cell_coordinates.y >= 0 and cell_coordinates.y < size.y)
	return within_x and within_y

# Clamps `cell_coordinates` to be within the grid
#
# Note: grid_position must be given like grid coordinates, not world coordinates
func clamp_grid_pos(grid_position: Vector2) -> Vector2:
	var pos := grid_position
	pos.x = clamp(grid_position.x, 0, size.x)
	pos.y = clamp(grid_position.y, 0, size.y)
	
	return grid_position

# Return a cell position as an index in 1D array
func as_index(cell: Vector2) -> int:
	var index: int = (cell.y * size.x) + cell.x
#	print(index)
	return index
