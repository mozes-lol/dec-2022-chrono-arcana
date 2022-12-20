extends AnimatedSprite3D

export var normal_animspeed = 10

var dashing = false
var walking = false

onready var move_keys = get_parent().move_keys

func _process(_delta):
	move_keys = get_parent().move_keys
	dashing = get_parent().dashing
	walking = get_parent().walking
	
	play()
	
	if dashing:
		frame = 1
		stop()
	
	if walking:
		frames.set_animation_speed("idle-walk", normal_animspeed)
	else:
		frame = 0
		stop()
