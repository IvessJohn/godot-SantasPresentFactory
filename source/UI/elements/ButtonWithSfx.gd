extends Button
class_name ButtonWithSFX


export(AudioStream) var sfx_click: AudioStream = null

func _ready():
	connect("pressed", self, "_play_click_sfx")

func _play_click_sfx():
	SfxPlayer.play_sfx(sfx_click)
