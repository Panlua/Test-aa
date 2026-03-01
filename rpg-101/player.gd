extends CharacterBody2D

@onready var cooldown_timer: Timer = $"L_Attack/Cooldown Timer"
const SPEED = 900.0
const JUMP_VELOCITY = -900.0
const Hollow_Jump = -1350.0
var Health = 1
var Can_Attack = true
var Face=0

func _physics_process(delta: float) -> void:
	$L_Attack.monitoring=false
	$R_Attack.monitoring=false
	$UP_Attack.monitoring=false
	$DOWN_Attack.monitoring=false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var UPanDown := Input.get_axis("Down","Up")
	var direction := Input.get_axis("Left", "Right")
	if direction==-1:
		Face=-1
	if direction==1:
		Face=1
	if UPanDown==-1:
		Face=0
	if UPanDown==1:
		Face=2

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("Light Attack") and Can_Attack == true and Face==1:
		$L_Attack.show()
		Can_Attack=false
		cooldown_timer.start()
		$L_Attack.monitoring=true
	if Input.is_action_just_pressed("Light Attack") and Can_Attack == true and Face==-1:
		$R_Attack.show()
		Can_Attack=false
		cooldown_timer.start()
		$R_Attack.monitoring=true
	if Input.is_action_just_pressed("Light Attack") and Can_Attack == true and Face==0:
		$DOWN_Attack.show()
		Can_Attack=false
		cooldown_timer.start()
		$DOWN_Attack.monitoring=true
	if Input.is_action_just_pressed("Light Attack") and Can_Attack == true and Face==2:
		$UP_Attack.show()
		Can_Attack=false
		cooldown_timer.start()
		$UP_Attack.monitoring=true
	if Health==0:
		get_tree().quit()
	move_and_slide()
	
	for i in get_slide_collision_count():
		if not get_slide_collision(i).get_collider().is_class("TileMapLayer"):
			if get_slide_collision(i).get_collider().collision_layer == 129:
				Health -= 1

func _on_cooldown_timer_timeout():
	Can_Attack=true
	$L_Attack.monitoring = false
	$L_Attack.hide()
	$R_Attack.monitoring = false
	$R_Attack.hide()
	$UP_Attack.monitoring = false
	$UP_Attack.hide()
	$DOWN_Attack.monitoring = false
	$DOWN_Attack.hide()


func _on_down_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		velocity.y = Hollow_Jump
