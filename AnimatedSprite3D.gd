extends AnimatedSprite3D

export var normal_animspeed = 10

var dashing
var running

onready var move_keys = get_parent().move_keys

func _process(_delta):
	move_keys = get_parent().move_keys
	
	dashing = false
	running = false
		
	if move_keys[5]:
		dashing = true
	
	if move_keys.has(true):
		running = true
	
	play()
	frames.set_animation_speed("idle", normal_animspeed)
	
	if running:
		frames.set_animation_speed("walk", normal_animspeed)
	
	if dashing || !get_parent().is_on_floor():
		frame = 1
		stop()
