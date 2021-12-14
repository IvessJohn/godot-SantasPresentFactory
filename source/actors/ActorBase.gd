extends KinematicBody2D
class_name Actor

export(int) var SPEED := 100

var velocity := Vector2.ZERO

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")


func _move():
	velocity = move_and_slide(velocity)
