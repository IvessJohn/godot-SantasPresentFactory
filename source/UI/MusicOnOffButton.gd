extends Button

export(Texture) var ICON_ON: Texture = preload("res://assets/art/UI/icons/music_on.png")
export(Texture) var ICON_OFF: Texture = preload("res://assets/art/UI/icons/music_off.png")

var music_is_playing := true setget set_music_is_playing


func set_music_is_playing(value):
	if music_is_playing != value:
		music_is_playing = value
		
		if music_is_playing:
			SoundtrackPlayer.streamPlayer.volume_db = 0
			icon = ICON_ON
		else:
			SoundtrackPlayer.streamPlayer.volume_db = -60
			icon = ICON_OFF

func _on_MusicOnOffButton_pressed():
	self.music_is_playing = !music_is_playing
