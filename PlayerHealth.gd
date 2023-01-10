extends ProgressBar

onready var playerHealth = get_node("/root/Map_Prototype/25DPlayerTest")

func _process(delta):
	value = playerHealth.get("health")
