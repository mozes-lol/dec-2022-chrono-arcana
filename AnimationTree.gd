extends AnimationTree

onready var state_machine = get("parameters/playback")
onready var move_keys = get_parent().move_keys

func _process(_delta):
	move_keys = get_parent().move_keys
	
	if move_keys[2] && !move_keys[3]:
		if move_keys[0] && !move_keys[1]:
			state_machine.travel("upleft")
			return
		if move_keys[1] && !move_keys[0]:
			state_machine.travel("downleft")
			return

		state_machine.travel("left")
		return

	if move_keys[3] && !move_keys[2]:
		if move_keys[0] && !move_keys[1]:
			state_machine.travel("upright")
			return
		if move_keys[1] && !move_keys[0]:
			state_machine.travel("downright")
			return

		state_machine.travel("right")
		return

	if move_keys[0] && !move_keys[1]:
		state_machine.travel("up")
		return

	if move_keys[1] && !move_keys[0]:
		state_machine.travel("down")
		return
