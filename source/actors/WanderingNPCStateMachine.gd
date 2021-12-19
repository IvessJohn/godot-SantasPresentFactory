extends StateMachine

func _ready():
	add_state("idle")
	add_state("move")
	call_deferred("set_state", states.idle)
#	call_deferred("set_state", states.move)

func _state_logic(delta):
	match state:
		states.idle:
			parent.velocity = Vector2.ZERO
		states.move:
			parent.velocity = parent.SPEED * parent.wander_direction
			parent.animTree.set("parameters/idle/blend_position", parent.wander_direction)
			parent.animTree.set("parameters/move/blend_position", parent.wander_direction)
	
	parent._move()

func _get_transition(delta):
	match state:
		states.idle:
			if parent.should_wander():
				return states.move
		states.move:
			if parent.should_idle():
				return states.idle

func _exit_state(old_state, new_state):
	pass

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.idleTimer.start(parent.get_idleTimer_new_duration())
			parent.animState.travel("idle")
		states.move:
			parent.wanderTimer.start(parent.get_wanderTimer_new_duration())
			parent.animState.travel("move")
			
			var deg = rand_range(0, 360)
			parent.wanderRayCast.rotation_degrees = deg
			parent.wander_direction = Vector2.RIGHT.rotated(deg2rad(deg))
