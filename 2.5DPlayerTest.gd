extends KinematicBody

# Set default speeds
export var normal_speed = 10
export var dash_speed = 30
export var jump_height = 18

var speed = normal_speed
var velocity = Vector3.ZERO
var input_velocity = Vector3.ZERO

# Set movement acceleration & decceleration rate
export var normal_accel = 5
var gravity = -90

var accel = normal_accel

export var can_dash = true
export var can_jump = true
export var can_move = true

var dashing = false

export var stamina_consump = 0 # Only values <= max_stamina
export var max_stamina = 100
var stamina = max_stamina

export var max_health = 100
var health = max_health

onready var current_map = get_node_or_null("../")
onready var move_keys = [false, false, false, false]

func _process(_delta):
	moveInput(Input)
	
#	Respawn upon falling into the void
	if translation.y < -20:
		translation = Vector3(0, 1, 0)
	if can_move:
		if Input.is_action_pressed("move_up"):
			move_keys[0] = true
		if Input.is_action_pressed("move_down"):
			move_keys[1] = true
		if Input.is_action_pressed("move_left"):
			move_keys[2] = true
		if Input.is_action_pressed("move_right"):
			move_keys[3] = true
		
# We don't need the jump and dash function for the time being
#		if Input.is_action_just_pressed("space"):
#			move_keys[4] = true
#		if Input.is_action_just_pressed("shift"):
#			move_keys[5] = true

func _physics_process(_delta):
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
	
	input_velocity.y = gravity
	
	velocity.x = move_toward(velocity.x, input_velocity.x, accel) # velocity.linear_interpolate(input_velocity, 0.2)
	velocity.y = lerp(velocity.y, input_velocity.y, 0.0098)
	velocity.z = move_toward(velocity.z, input_velocity.z, accel)
	
	velocity = move_and_slide(transform.basis.xform(velocity), Vector3(0, 1, 0))
	
func moveInput(e):
	move_keys.fill(false)
	
	if !can_move:
		return
	
	if e.is_action_pressed("move_up"):
		move_keys[0] = true
	if e.is_action_pressed("move_down"):
		move_keys[1] = true
	if e.is_action_pressed("move_left"):
		move_keys[2] = true
	if e.is_action_pressed("move_right"):
		move_keys[3] = true
	
	if e.is_action_pressed("space"):
		jump()

	if e.is_action_just_pressed("shift") && move_keys.has(true):
		dash()

func jump():
	if is_on_floor() && can_jump:
		velocity.y = jump_height

func dash():
	if !can_dash || stamina < stamina_consump || !move_keys.has(true):
		return
	
	dashing = true
	can_dash = false
	$CollisionShape.disabled = true
	stamina -= stamina_consump
	speed = dash_speed
	accel = speed
	timer(0.05, "dashEnd")
	timer(0.5, "dashCD")

func dashEnd():
	dashing = false
	$CollisionShape.disabled = false
	speed = normal_speed
	accel = normal_accel

func dashCD():
	can_dash = true

func timer(length, nextFunc):
	var timer = Timer.new()
	timer.connect("timeout", self, nextFunc)
	timer.wait_time = length
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _on_Hitbox_body_entered(body):
	print_debug(body.is_attacking)
	if body.is_attacking == true:
		health -= body.get("damage")
	
