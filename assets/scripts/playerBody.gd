extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D


func _physics_process(delta):
	# Animations
	if (velocity.x < 0):
		animation.flip_h = false
		animation.play("run")
	elif (velocity.x > 0):
		animation.flip_h = true
		animation.play("run")
	else:
		animation.play("idle")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animation.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animation.play("jump")
		velocity.y = JUMP_VELOCITY

	# Handle duck.
	if Input.is_action_pressed("duck") and is_on_floor():
		animation.play("duck")
		position.y += 1

	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)

	move_and_slide()
	
