tool
extends Node2D
class_name Cursor


signal accept_pressed(cell)
signal accept_removed(cell)
signal moved(new_cell)

export var grid: Resource = preload("res://source/resources/Grid.tres")
var _selected_resource: PlaceableObjectResource = null setget set_selected_resource

# Time before the cursor can move again in seconds.
export(float) var ui_cooldown := 0.1

export(bool) var is_active := false setget set_is_active

var cell := Vector2.ZERO setget set_cell

onready var _timer = $Timer


func _unhandled_input(event):
	if is_active:
		# 
		# PRESSING THE CELL
		#
	
		# If mouse moved, capture this input and update the cursor's grid position
		if event is InputEventMouseMotion:
			self.cell = grid.calculate_grid_position(event.position)
		# Elif we have already been over the wanted cell and we press it
		elif event.is_action_pressed("place_tile") or \
				event.is_action_pressed("ui_accept"):
#				event.is_action("place_tile") or \
			emit_signal("accept_pressed", cell)
			get_tree().set_input_as_handled()
		
		# Here's the code for tile removal
		if event.is_action_pressed("remove_tile"):
			emit_signal("accept_removed", cell)
			get_tree().set_input_as_handled()
		
		#
		# MOVING THE CURSOR
		#
		var should_move: bool = event.is_pressed()
		
#		if event.is_echo():
#			should_move = should_move and _timer.is_stopped()
		
		if !should_move:
			return
		
		# Update the cursor's current cell based on the input direction using keyboard
		if event.is_action("ui_right"):
			self.cell += Vector2.RIGHT
		elif event.is_action("ui_up"):
			self.cell += Vector2.UP
		elif event.is_action("ui_left"):
			self.cell += Vector2.LEFT
		elif event.is_action("ui_down"):
			self.cell += Vector2.DOWN

# Use _draw() to draw a rectangle around the selected cell
func _draw():
	draw_rect(Rect2(-grid.cell_size * 0.5, grid.cell_size), Color.springgreen, false, 1.5)

func set_cell(value: Vector2):
	var new_cell: Vector2 = grid.clamp_grid_pos(value)
	if new_cell.is_equal_approx(cell):
		return
	
	cell = new_cell
	
	position = grid.calculate_map_position(cell)
	emit_signal("moved", cell)
	_timer.start()

func set_is_active(value):
	if value != is_active:
		is_active = value
		visible = is_active

func set_selected_resource(value):
	if _selected_resource != value:
		_selected_resource = value
		if _selected_resource:
			$SelectedObjectSprite.texture = _selected_resource.texture
