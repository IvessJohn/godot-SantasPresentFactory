extends Node
class_name SoundtrackPlayerClass

enum THEMES {
	MAIN_MENU,
	SANDBOX
}
export(Dictionary) var TRACKS = {
	THEMES.MAIN_MENU: [],
	THEMES.SANDBOX: [
			preload("res://source/music/VOiD1/5. The night of Christmas.wav"),
			preload("res://source/music/VOiD1/3. The Jingles of the North.wav")]
}

var current_theme: int = THEMES.MAIN_MENU
var current_track: int = 0
var is_repeating: bool = true

onready var streamPlayer: AudioStreamPlayer = $AudioStreamPlayer


func play_soundtrack(theme: int, repeat_themes: bool = true):
	streamPlayer.stream_paused = false
	if current_theme != theme or !streamPlayer.playing:
		is_repeating = false # Prevent accidentally starting an old track playing
								# again when next command is stop()
		
		streamPlayer.stop()
		
		is_repeating = repeat_themes
		current_theme = theme
		current_track = 0
		
		var theme_tracks: Array = TRACKS[current_theme]
		if theme_tracks != []:
			streamPlayer.stream = theme_tracks[current_track]
			streamPlayer.play()


func replay_theme():
	streamPlayer.stream = TRACKS[current_theme][0]
	if TRACKS[current_theme].size() > 1:
		streamPlayer.stream = TRACKS[current_theme][1]
	streamPlayer.play()

func _on_AudioStreamPlayer_finished():
	if is_repeating:
		replay_theme()

func pause_soundtrack():
	streamPlayer.stream_paused = true
