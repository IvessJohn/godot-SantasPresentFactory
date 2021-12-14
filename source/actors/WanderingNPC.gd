extends Actor
class_name WanderingNPC


# Min and max duration of staying idle
export(Dictionary) var idle_time = {"min": 2.0, "max": 10.0}
# Min and max duration of wandering
export(Dictionary) var wander_time = {"min": 2.0, "max": 10.0}

var wander_direction: Vector2 = Vector2.ZERO

onready var wanderSM = $WanderingNPCStateMachine
onready var wanderTimer = $WanderTimer
onready var idleTimer = $IdleTimer
onready var wanderRayCast = $WanderRayCast2D


func should_wander() -> bool:
	return idleTimer.is_stopped()

func should_idle() -> bool:
	return (wanderTimer.is_stopped() or wanderRayCast.is_colliding())

func _physics_process(delta):
	#Update AnimationTree for showing proper animations
	animTree.set("parameters/Idle/blend_position", wander_direction)
	animTree.set("parameters/Move/blend_position", wander_direction)

func get_wanderTimer_new_duration() -> float:
	return rand_range(wander_time["min"], wander_time["max"])

func get_idleTimer_new_duration() -> float:
	return rand_range(idle_time["min"], idle_time["max"])
