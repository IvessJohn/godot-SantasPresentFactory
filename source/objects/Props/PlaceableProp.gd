extends StaticBody2D
class_name PlaceableProp


export(AudioStream) var sfx_place: AudioStream = null
export(AudioStream) var sfx_remove: AudioStream = null

onready var sprite = $VariableSprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer


func _ready():
	pass
