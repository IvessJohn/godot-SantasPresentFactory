extends Control

onready var main = $PauseMenuContainer
onready var credits = $CreditsContainer

export(AudioStream) var sfx_popup: AudioStream = null
export(AudioStream) var sfx_hide: AudioStream = null


func _open_credits():
	credits.show()
	main.hide()

func _return_to_main():
	main.show()
	credits.hide()

func _open_screenshots():
	pass


func _on_Back_pressed():
	_return_to_main()

func _on_ButtonCredits_pressed():
	_open_credits()


func _on_ButtonQuit_pressed():
	get_tree().quit()


func _on_ButtonScreenshots_pressed():
	_open_screenshots()


func _on_visibility_changed():
	if visible:
		SfxPlayer.play_sfx(sfx_popup)
	else:
		SfxPlayer.play_sfx(sfx_hide)
