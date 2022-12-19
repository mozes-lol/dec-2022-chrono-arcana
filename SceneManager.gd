extends Node

func _ready() -> void:
	print_debug("Scene Manager Active")

func ChangeScene(sceneTarget):
	get_tree().change_scene(sceneTarget)
	print_debug("Changing Scene")
