extends AnimationTree

onready var state_machine = get("parameters/playback")
onready var move_keys = get_parent().move_keys

func _process(_delta):
	move_keys = get_parent().move_keys
	
	if move_keys[2] && !move_keys[3]:
		state_machine.travel("face-left")
		return

	if move_keys[3] && !move_keys[2]:
		state_machine.travel("face-right")
		return
#	
	if move_keys[0] || move_keys[1] || !get_parent().is_on_floor():
		state_machine.travel("run")
		return
	
	state_machine.travel("idle")
