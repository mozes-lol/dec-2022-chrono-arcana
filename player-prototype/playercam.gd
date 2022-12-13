extends Node2D

onready var player = get_node("/root/leveldemo/player2")


func _ready():
	pass

func _process(_delta):
	var mouse = get_viewport().get_mouse_position()
	position = player.position

	
	if mouse != Vector2(0, 0):
		$responsivecam.position = (mouse - (OS.get_window_size())/2)
	else:
		$responsivecam.position = player.position
