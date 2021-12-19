extends Node2D


onready var _levelUI = $CanvasLayer/LevelUI
onready var _pauseMenu = $CanvasLayer/PauseMenu
onready var _gameBoard = $GameBoard


func _ready():
	randomize()
	SoundtrackPlayer.play_soundtrack(SoundtrackPlayerClass.THEMES.SANDBOX)

func _unhandled_input(event):
	if event.is_action_pressed("ui_pause"):
		if not _pauseMenu.visible:
			_levelUI.hide()
			_gameBoard.sleep()
			_pauseMenu.show()
		else:
			_pauseMenu.hide()
			_levelUI.show()
			_gameBoard.wake_up()

