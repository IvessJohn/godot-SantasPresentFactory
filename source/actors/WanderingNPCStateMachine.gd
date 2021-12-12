extends StateMachine

func _ready():
	add_state("idle")
	add_state("move")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	pass

func get_transition(delta):
	pass

func _exit_state(old_state, new_state):
	pass

func _enter_state(new_state, old_state):
	pass
