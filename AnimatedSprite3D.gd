extends AnimatedSprite3D

export var normal_animspeed = 10

var dashing = false

onready var move_keys = get_parent().move_keys

func _process(_delta):
	move_keys = get_parent().move_keys
	dashing = get_parent().dashing
	
	frames.set_animation_speed("idle", normal_animspeed)
	frames.set_animation_speed("walk", normal_animspeed)
	
	play()
	
	if dashing || !get_parent().is_on_floor():
		frame = 1
		stop()
