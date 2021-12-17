extends KinematicBody2D
class_name Actor

signal clicked

export(int) var SPEED := 100

var velocity := Vector2.ZERO

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")


func _move():
	velocity = move_and_slide(velocity)


func _on_InteractionArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("clicked")

func _on_clicked():
	print(name + " was just clicked!")
