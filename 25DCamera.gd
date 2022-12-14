extends Camera

var playerTargetPosition
var cameraPosition
var cameraOffsetPositionToPlayer = Vector3.ZERO
var playerTargetPositionPerFrame = Vector3.ZERO
export var cameraManualOffset = Vector3.ZERO # If further offset tweaking is not needed, leave the values for all axis as 0
export var followSpeed = 0.1 # How fast does the camera follow the player

func _ready():
	
	# Getting the position of the player
	playerTargetPosition = get_node("/root/Map_Prototype/25DPlayerTest").translation
	# Getting the position of the camera
	cameraPosition = translation
	
	# Getting the difference of the two positions
	# Remember: We're looking for the difference for each axis; Not the distance
	# That's why the process of subtracting axis is separate
	var offsetX = playerTargetPosition.x + cameraPosition.x
	var offsetY = playerTargetPosition.y + cameraPosition.y
	var offsetZ = playerTargetPosition.z + cameraPosition.z
	
	# This is the final offset that will be used
	cameraOffsetPositionToPlayer = Vector3(offsetX, offsetY, offsetZ) + cameraManualOffset

func _process(delta: float) -> void:
	Engine.set_target_fps(Engine.get_iterations_per_second()) # idk if this will solve smoothing jitter... UPDATE: It did lol
	# The position of the player will be checked every frame
	playerTargetPositionPerFrame = get_node("/root/Map_Prototype/25DPlayerTest").translation
	translation = lerp(translation, playerTargetPositionPerFrame + cameraOffsetPositionToPlayer, followSpeed)
