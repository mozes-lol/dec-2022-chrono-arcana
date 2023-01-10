extends ProgressBar

export var health = 100
onready var playerHealth = get_node("/root/Map_Prototype/25DPlayerTest")

func _process(delta):
	print_debug(str(playerHealth.get("health")))
	value = playerHealth.get("health")
