extends AnimatedSprite3D

export var normal_animspeed = 10

var dashing = false
var running = false

onready var move_keys = get_parent().move_keys

func _process(_delta):
	move_keys = get_parent().move_keys
	dashing = get_parent().dashing
	running = get_parent().running
	
	play()
	frames.set_animation_speed("idle", normal_animspeed)
	
	if running:
		frames.set_animation_speed("walk", normal_animspeed)
	
	if dashing:
		frame = 1
		stop()
