extends Node

var Scene

# All scenes involved in the main game should be included here.
# Scene = get_tree().get_node("res://2.5DMapPrototype.tscn")

func _ready() -> void:
	print_debug("")

func ChangeScene(sceneTarget):
	get_tree().change_scene(sceneTarget) 
