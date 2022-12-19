extends KinematicBody

export var normal_speed = 10
export var dash_speed = 30
export var crouch_speed = 5

var speed = normal_speed
var velocity = Vector3.ZERO
var input_velocity = Vector3.ZERO

export var normal_accel = 5
export var normal_deccel = 5

var accel = normal_accel
var deccel = normal_deccel

export var take_damage = true
export var max_health = 100
var health = max_health

var walking = false
var dashing = false
var can_dash = true
var can_move = true

export var stamina_consump = 0 # Only a value <= 100
export var max_stamina = 100
var stamina = max_stamina

onready var current_map = get_node_or_null("../")
onready var move_keys = [false, false, false, false]

func _input(_event):
	move_keys = [false, false, false, false]
	
	if Input.is_action_pressed("move_up"):
		move_keys[0] = true
	if Input.is_action_pressed("move_down"):
		move_keys[1] = true
	if Input.is_action_pressed("move_left"):
		move_keys[2] = true
	if Input.is_action_pressed("move_right"):
		move_keys[3] = true
	
	if Input.is_action_just_pressed("space"):
		dash()
	if Input.is_action_just_pressed("shift"):
		walk()
	if Input.is_action_just_released("shift"):
		walkRelease()


func _process(_delta):
	# Sticks the player on the ground
	translation.y = current_map.get_node_or_null("Floor").translation.y + current_map.get_node_or_null("Floor").scale.y

func _physics_process(_delta):
	if can_move:
		getMovement()
		
		if input_velocity.length() > 0:
			velocity.x = move_toward(velocity.x, input_velocity.x, accel) #velocity.linear_interpolate(input_velocity, 0.2)
			velocity.z = move_toward(velocity.z, input_velocity.z, accel)
		else:
			velocity.x = move_toward(velocity.x, 0, deccel) #velocity.linear_interpolate(Vector2.ZERO, 0.2)
			velocity.z = move_toward(velocity.z, 0, deccel)
		
		velocity = move_and_slide(transform.basis.xform(velocity))
	else:
		velocity = Vector3.ZERO

func getMovement():
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

func delay(length, nextFunc):
	var timer = Timer.new()
	timer.connect("timeout", self, nextFunc)
	timer.wait_time = length
	timer.one_shot = true
	add_child(timer)
	timer.start()

func dash():
	if can_dash && stamina >= stamina_consump && velocity != Vector3.ZERO:
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

func walk():
	walking = true
	speed = crouch_speed
	can_dash = false

func walkRelease():
	walking = false
	speed = normal_speed
	can_dash = true
