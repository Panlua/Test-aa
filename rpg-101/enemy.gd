extends CharacterBody2D

@onready var timer: Timer = $Timer
const SPEED = 300.0
var direction = 1.0
var knockback_lx = 6000.0
var knockback_rx = -6000.0
var knockback_uy = -1000.0
var knzxockback_dx = 1000.0
var Why=true
var health = 9999999
var MAX_health = 9999999
func _ready() -> void:
	timer.start()

func _physics_process(delta: float) -> void:
	$ProgressBar.value=MAX_health/health
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if health <= 0:
		queue_free()
	if direction:
		velocity.x = direction * SPEED
	move_and_slide()
	
	#for i in get_slide_collision_count():
	#	var collider = get_slide_collision(i).get_collider()
	#	if not collider.is_class("TileMapLayer"):
	#		pass

func _on_timer_timeout() -> void:
	direction *=-1
	
func _on_l_attack_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		health-=20
func _on_r_attack_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		health-=20

func _on_up_attack_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		health-=20
		
func _on_down_attack_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		health-=20
