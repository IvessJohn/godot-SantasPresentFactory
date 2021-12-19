extends ColorRect

export(String, FILE) var NEXT_SCENE := ""


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(NEXT_SCENE)
