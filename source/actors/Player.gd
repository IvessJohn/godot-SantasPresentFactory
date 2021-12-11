extends "res://source/actors/ActorBase.gd"
class_name Player

func _ready():
	pass

func _physics_process(delta):
	var input_dir: Vector2 = get_input_direction()
	if input_dir != Vector2.ZERO:
		velocity = SPEED * input_dir
	else:
		velocity = Vector2.ZERO
	_move()
 
 
func get_input_direction() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_direction = input_direction.normalized()
	
	return input_direction
