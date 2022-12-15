extends Node

var musicVolume = 100
var SFXVolume = 100

func _ready() -> void:
	print_debug("Global Settings Active") # just to check if the global settings exist in the scene
	print_debug("Music Volume: " + str(musicVolume))
	print_debug("SFX Volume " + str(SFXVolume))
