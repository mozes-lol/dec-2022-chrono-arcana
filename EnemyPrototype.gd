extends KinematicBody

# Enemy Movement
export var path_to_player := NodePath()
export var move_speed = 5
var _velocity := Vector3.ZERO
onready var _agent: NavigationAgent = $NavigationAgent
onready var _player = get_node(path_to_player)
onready var _timer: Timer = $Pathfinding

#Enemy Attack
onready var attackPrepare: Timer = $AttackPrepare
onready var attackDuration: Timer = $AttackDuration
onready var attackCooldown: Timer = $AttackCooldown
onready var attackCollision: CollisionShape = $AttackRange/CollisionShape
var can_attack = true
var is_preparing_to_attack = false
var is_attacking = false
export var damage = 10

func _ready() -> void:
	_agent.set_target_location(_player.global_translation)
	_timer.connect("timeout", self, "_update_pathfinding")
	
func _physics_process(delta: float) -> void:
	global_translation.y = 1
		
	if is_preparing_to_attack == true:
		return
	elif is_attacking == true:
		move_and_slide(_velocity * 2)
		return
	
	if _agent.is_navigation_finished():
		return
	
	var direction = global_translation.direction_to(_agent.get_next_location())
	
	var desired_velocity = direction * move_speed
	var steering = (desired_velocity - _velocity) * delta * 4.0
	_velocity += steering
	
	_velocity = move_and_slide(_velocity)

func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_translation)

func _on_AttackRange_body_entered(body: Node) -> void:
	if can_attack == true:
		attackCollision.disabled = true
		attackPrepare.start()
		is_preparing_to_attack = true
		can_attack = false

func _on_AttackPrepare_timeout() -> void:
	attackDuration.start()
	is_preparing_to_attack = false
	is_attacking = true

func _on_AttackDuration_timeout() -> void:
	attackCooldown.start()
	is_attacking = false

func _on_AttackCooldown_timeout() -> void:
	can_attack = true
	attackCollision.disabled = false
