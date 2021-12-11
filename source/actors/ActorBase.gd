extends KinematicBody2D
class_name Actor

export(int) var SPEED := 100

var velocity := Vector2.ZERO


func _move():
	velocity = move_and_slide(velocity)
