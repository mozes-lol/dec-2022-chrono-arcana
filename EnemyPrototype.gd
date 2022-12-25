extends KinematicBody

var path = []
var path_node = 0
var is_preparing_to_attack = false
var direction = Vector3.ZERO

var speed = 10 # how fast the enemy moves to the player
var dash_attack_speed = 50

func _ready() -> void:
	$Timer.start()

onready var nav = get_parent() # gets the NavigationMeshInstance Node
onready var player = $"/root/Map_Prototype/Navigation/25DPlayerTest"

func _process(delta: float) -> void:
	print_debug(direction)
	# We flip the sprite depending on the direction of this enemy.
	# (Yes, we'll prolly use the animated sprite node later on; But this is just for demonstration purposes.)
	if direction.x > 0:
		$Sprite3D.flip_v = false
	elif direction.x < 0:
		$Sprite3D.flip_v = true

func _physics_process(delta: float) -> void:
	if is_preparing_to_attack == true:
		return # We do a guard clause to prevent the enemy from doing anymore movement in the time being.
	if path_node < path.size():
		direction = (path[path_node] - global_transform.origin) 
		direction.y += .45  # This will push the enemy upward, preventing it from "semi-sinking" to the ground
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized()  * speed, Vector3.UP)

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout() -> void:
	move_to(player.global_transform.origin)

func _on_Area_body_entered(body: Node) -> void:
	is_preparing_to_attack = true
