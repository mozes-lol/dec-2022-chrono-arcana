extends Camera

export var cameraManualOffset = Vector3.ZERO # If further offset tweaking is not needed, leave the values for all axis as 0
export var followSpeed = 0.1 # How fast does the camera follow the player

# Getting the position of the player
onready var playerTargetPosition = get_node_or_null("/root/Map_Prototype/Navigation/25DPlayerTest").translation
# Getting the position of the camera
onready var cameraPosition = translation

# Getting the difference of the two positions
# Remember: We're looking for the difference for each axis; Not the distance
# That's why the process of subtracting axis is separate
onready var offsetX = playerTargetPosition.x + cameraPosition.x
onready var offsetY = playerTargetPosition.y + cameraPosition.y
onready var offsetZ = playerTargetPosition.z + cameraPosition.z

# This is the final offset that will be used
onready var cameraOffsetPositionToPlayer = Vector3(offsetX, offsetY, offsetZ) + cameraManualOffset

onready var playerTargetPositionPerFrame = Vector3.ZERO

func _process(_delta: float) -> void:
	Engine.set_target_fps(Engine.get_iterations_per_second()) # idk if this will solve smoothing jitter... UPDATE: It did lol
	# The position of the player will be checked every frame
	playerTargetPositionPerFrame = get_node_or_null("/root/Map_Prototype/Navigation/25DPlayerTest").translation
	translation = lerp(translation, playerTargetPositionPerFrame + cameraOffsetPositionToPlayer, followSpeed)
