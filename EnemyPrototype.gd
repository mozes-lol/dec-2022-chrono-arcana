extends KinematicBody

var path = []
var path_node = 0

var speed = 10 # how fast the enemy moves to the player

func _ready() -> void:
	$Timer.start()

onready var nav = get_parent() # gets the NavigationMeshInstance Node
onready var player = $"/root/Map_Prototype/Navigation/25DPlayerTest"

func _physics_process(delta: float) -> void:
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout() -> void:
	move_to(player.global_transform.origin)
