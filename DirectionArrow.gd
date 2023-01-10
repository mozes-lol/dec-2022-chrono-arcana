extends Spatial

var playerVelocity

func _process(delta):
	playerVelocity = get_parent().get("velocity")
	print_debug(playerVelocity)
	
	if playerVelocity.x >= 1 && playerVelocity.z >= 1: # top left
		rotation_degrees.y = 45
	elif playerVelocity.x <= -1 && playerVelocity.z >= 1: # top right
		rotation_degrees.y = 315
	elif playerVelocity.x >= 1 && playerVelocity.z <= -1: # down left
		rotation_degrees.y = 135
	elif playerVelocity.x <= -1 && playerVelocity.z <= -1: # down right
		rotation_degrees.y = 225
	elif playerVelocity.x >= 1: # left
		rotation_degrees.y = 90
	elif playerVelocity.x <= -1: # right
		rotation_degrees.y = 270
	elif playerVelocity.z >= 1: # up
		rotation_degrees.y = 0
	elif playerVelocity.z <= -1: # down
		rotation_degrees.y = 180
