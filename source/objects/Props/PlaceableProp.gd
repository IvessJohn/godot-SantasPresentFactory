extends StaticBody2D
class_name PlaceableProp


export(AudioStream) var sfx_place: AudioStream = null
export(AudioStream) var sfx_remove: AudioStream = null

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer
