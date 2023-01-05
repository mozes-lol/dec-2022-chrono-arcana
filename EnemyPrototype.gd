extends KinematicBody

export var path_to_player := NodePath()
export var move_speed = 5

var _velocity := Vector3.ZERO

onready var _agent: NavigationAgent = $NavigationAgent
onready var _player = get_node(path_to_player)
onready var _timer: Timer = $Timer

func _ready() -> void:
	_agent.set_target_location(_player.global_translation)
	_timer.connect("timeout", self, "_update_pathfinding")
	
func _physics_process(delta: float) -> void:
	global_translation.y = 1
	
	if _agent.is_navigation_finished():
		return
	
	var direction = global_translation.direction_to(_agent.get_next_location())
	
	var desired_velocity = direction * move_speed
	var steering = (desired_velocity - _velocity) * delta * 4.0
	_velocity += steering
	
	_velocity = move_and_slide(_velocity)

func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_translation)
