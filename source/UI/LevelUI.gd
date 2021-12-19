extends Control

#export(NodePath) var game_board_path: NodePath setget set_game_board_path
var game_board: Node = null



func _ready():
	if get_tree().has_group("GameBoard"):
		game_board = get_tree().get_nodes_in_group("GameBoard")[0]

# A tile has been chosen
func _on_ObjectGrid_object_chosen(object_resource):
	if is_instance_valid(game_board):
		game_board._selected_resource = object_resource

#func set_game_board_path(value):
#	if game_board_path != value:
#		game_board_path = value
#		game_board = get_node(game_board_path)
