extends KinematicBody

# Set default speeds
export var normal_speed = 10
export var dash_speed = 30

var speed = normal_speed
var velocity = Vector3.ZERO
var input_velocity = Vector3.ZERO

# Set movement acceleration & decceleration rate
export var normal_accel = 5

var accel = normal_accel

var running = false
var dashing = false

export var can_dash = true
export var can_move = true

export var stamina_consump = 0 # Only values <= max_stamina
export var max_stamina = 100
var stamina = max_stamina

onready var current_map = get_node_or_null("../")
onready var move_keys = [false, false, false, false, false, false]

func _input(_event):
	move_keys = [false, false, false, false, false, false]
	
	if can_move:
		if Input.is_action_pressed("move_up"):
			move_keys[0] = true
		if Input.is_action_pressed("move_down"):
			move_keys[1] = true
		if Input.is_action_pressed("move_left"):
			move_keys[2] = true
		if Input.is_action_pressed("move_right"):
			move_keys[3] = true
		
		if Input.is_action_just_pressed("space"):
			move_keys[4] = true
		if Input.is_action_just_pressed("shift"):
			move_keys[5] = true
			dash()


func _process(_delta):
#	Sticks the player on the ground
#	translation.y = current_map.get_node_or_null("Floor").translation.y + current_map.get_node_or_null("Floor").scale.y
	
	move_keys[4] = false
	pass

func _physics_process(_delta):
	getMovement()

func getMovement():
	if move_keys.has(true):
		running = true
	else:
		running = false
	
	input_velocity = Vector3.ZERO
	
	if move_keys[3]:
		input_velocity.x -= 1
	if move_keys[2]:
		input_velocity.x += 1
	if move_keys[1]:
		input_velocity.z -= 1
	if move_keys[0]:
		input_velocity.z += 1
	
	input_velocity = input_velocity.normalized() * speed
	
	if move_keys[4]:
		input_velocity.y = 2000
	else:
		input_velocity.y = -90
	
	
	velocity.x = move_toward(velocity.x, input_velocity.x, accel) # velocity.linear_interpolate(input_velocity, 0.2)
	velocity.y = lerp(velocity.y, input_velocity.y, 0.0098)
	velocity.z = move_toward(velocity.z, input_velocity.z, accel)
	
	velocity = move_and_slide(transform.basis.xform(velocity))

func delay(length, nextFunc):
	var timer = Timer.new()
	timer.connect("timeout", self, nextFunc)
	timer.wait_time = length
	timer.one_shot = true
	add_child(timer)
	timer.start()

func dash():
	if can_dash && stamina >= stamina_consump && move_keys.has(true):
		dashing = true
		can_dash = false
		stamina -= stamina_consump
		speed = dash_speed
		accel = speed
		delay(0.05, "dashEnd")

func dashEnd():
	dashing = false
	speed = normal_speed
	accel = normal_accel
	can_dash = true
