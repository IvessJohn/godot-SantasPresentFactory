extends YSort
class_name GameBoard

export(PackedScene) var PLACEMENT_PARTICLES: PackedScene = preload("res://source/FX/ObjectPlacementParticles.tscn")

const DIRECTIONS = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]

export(Resource) var grid: Resource = preload("res://source/resources/Grid.tres")

export(Dictionary) var SOUNDS := {
	"place": null,
	"replace": preload("res://source/SFX/replace.wav"),
	"remove": preload("res://source/SFX/impact.wav")
}

# Each key-value pair represents an object. The key is the position, the value is the reference to
# the object
var _objects := {}
var _props := {}
var _decorations := {}
var _actors := []
var _tiles := []

var _selected_resource: PlaceableObjectResource = null setget set_selected_resource

onready var _placement_overlay
onready var tilemaps := {
	PlaceableTileResource.TILE_PLACEMENT.GROUND: $GroundTileMap,
	PlaceableTileResource.TILE_PLACEMENT.SURFACE: $SurfaceTileMap
}
onready var objects := $Objects
onready var effects := $Effects


func sleep():
	$Cursor.is_active = false

func wake_up():
	$Cursor.is_active = true



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

func _on_Cursor_moved(_new_cell):
	pass

func _on_Cursor_accept_pressed(cell):
	SfxPlayer.play_sfx(SOUNDS["replace"])
	place_object(cell)

func _on_Cursor_accept_removed(cell):
	if is_cell_occupied(cell):
		SfxPlayer.play_sfx(SOUNDS["remove"], get_tree().current_scene, -5)
		remove_object(cell)

func set_selected_resource(value):
	if _selected_resource != value:
		_selected_resource = value
		$Cursor._selected_resource = _selected_resource
		print("_selected_resource = " + str(_selected_resource))




#
# OBEJCT PLACEMENT
#
func place_object(cell: Vector2):
#	print(can_place_object(cell, _selected_resource))
	if can_place_object(cell, _selected_resource):
		# Placing the object
		match _selected_resource.type:
			PlaceableObjectResource.OBJECT_TYPES.PROP:
				_place_prop(cell, _selected_resource)
			PlaceableObjectResource.OBJECT_TYPES.DECORATION:
				_place_decoration(cell, _selected_resource)
			PlaceableObjectResource.OBJECT_TYPES.ACTOR:
				_place_actor(cell, _selected_resource)
			PlaceableObjectResource.OBJECT_TYPES.TILE:
				_place_tile(cell, _selected_resource)
		
		# FX part
		var particles: CPUParticles2D = PLACEMENT_PARTICLES.instance()
		particles.texture = _selected_resource.ui_icon
		particles.position = grid.calculate_map_position(cell)
		objects.add_child(particles)

func can_place_object(cell, object_resource) -> bool:
	if not object_resource:
		return false
	
	match object_resource.type:
		PlaceableObjectResource.OBJECT_TYPES.PROP, \
		PlaceableObjectResource.OBJECT_TYPES.DECORATION:
			return object_resource.scene != null
		PlaceableObjectResource.OBJECT_TYPES.ACTOR:
			return (not _props.has(cell) and not _tiles.has(cell))
		PlaceableObjectResource.OBJECT_TYPES.TILE:
			return true
		PlaceableObjectResource.OBJECT_TYPES.BUILDING:
			return false
	
	return false

func is_cell_occupied(cell):
	if _objects.has(cell) or \
		tilemaps[PlaceableTileResource.TILE_PLACEMENT.SURFACE].get_cellv(cell) != TileMap.INVALID_CELL:
		return true
	return false

func _place_prop(cell, _prop_resource: PlaceableObjectResource):
	# If there is another tile/object at this position, remove it
	remove_object(cell)
	
	var object_scene: PackedScene = _prop_resource.scene
	var object_instance: Node2D = object_scene.instance()
	objects.add_child(object_instance)
	
#	print((cell))
	var object_pos: Vector2 = grid.calculate_map_position(cell)
	object_instance.global_position = object_pos
	
	_objects[cell] = object_instance
	_props[cell] = object_instance

func _place_decoration(cell, _decor_resource: PlaceableObjectResource):
	# If there is another tile/object at this position, remove it
	remove_object(cell)
	
	var object_scene: PackedScene = _decor_resource.scene
	var object_instance: Node2D = object_scene.instance()
	objects.add_child(object_instance)
	
#	print((cell))
	var object_pos: Vector2 = grid.calculate_map_position(cell)
	object_instance.global_position = object_pos
	
	_objects[cell] = object_instance
	_decorations[cell] = object_instance

func _place_actor(cell, _actor_resource: PlaceableObjectResource):
	var actor_scene: PackedScene = _actor_resource.scene
	var actor_instance: Node2D = actor_scene.instance()
	objects.add_child(actor_instance)
	
#	print((cell))
	var object_pos: Vector2 = grid.calculate_map_position(cell)
	actor_instance.global_position = object_pos
	
	_actors.append(actor_instance)
#	_objects[cell] = object_instance

func _place_tile(cell, _tile_resource: PlaceableTileResource):
	var tilemap: TileMap = tilemaps[_tile_resource.tile_placement]
	# If there is another tile/object at this position, remove it
	remove_object(cell)
	
	_tiles.append(cell)
	
	var tile_id: int = _tile_resource.tile_id
	tilemap.set_cellv(cell, tile_id)
	tilemap.update_bitmask_region()




#
# OBJECT REMOVAL
#
func remove_object(cell: Vector2):
	if is_cell_occupied(cell) and _can_remove_object(cell):
		if _objects.has(cell):
			var removed_object: Node2D = _objects[cell]
			removed_object.queue_free()
			_objects.erase(cell)
			if _props.has(cell):
				_props.erase(cell)
			elif _decorations.has(cell):
				_props.erase(cell)
			elif _tiles.has(cell):
				_tiles.erase(cell)
		
		elif tilemaps[PlaceableTileResource.TILE_PLACEMENT.SURFACE].get_cellv(cell) != TileMap.INVALID_CELL:
			var tilemap: TileMap = tilemaps[PlaceableTileResource.TILE_PLACEMENT.SURFACE]
			tilemap.set_cellv(cell, -1)
			tilemap.update_bitmask_region()

func _can_remove_object(cell: Vector2) -> bool:
	if _objects.has(cell) or \
		tilemaps[PlaceableTileResource.TILE_PLACEMENT.SURFACE].get_cellv(cell) != TileMap.INVALID_CELL:
		return true
	return false
