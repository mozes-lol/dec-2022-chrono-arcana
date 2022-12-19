extends AnimatedSprite3D

export var normal_animspeed = 10
export var walk_animspeed = 6

var dashing = false
var walking = false

onready var move_keys = get_parent().move_keys

func _process(_delta):
	move_keys = get_parent().move_keys
	dashing = get_parent().dashing
	walking = get_parent().walking
	
	if dashing:
		frame = 1
		stop()
	
	if walking:
		frames.set_animation_speed("up", walk_animspeed)
		frames.set_animation_speed("upright", walk_animspeed)
		frames.set_animation_speed("right", walk_animspeed)
		frames.set_animation_speed("downright", walk_animspeed)
		frames.set_animation_speed("down", walk_animspeed)
	else:
		frames.set_animation_speed("up", normal_animspeed)
		frames.set_animation_speed("upright", normal_animspeed)
		frames.set_animation_speed("right", normal_animspeed)
		frames.set_animation_speed("downright", normal_animspeed)
		frames.set_animation_speed("down", normal_animspeed)
	
	if move_keys[0] == move_keys[1] && move_keys[2] == move_keys[3]:
		frame = 0
		stop()
		return
	else:
		play()
	
