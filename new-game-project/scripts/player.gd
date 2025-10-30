extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var anim = $AnimatedSprite2D

# Multiplier for gravity strength
var gravity_multiplier: float = 1.0

func _physics_process(delta: float) -> void:
	# Apply gravity (scaled by multiplier)
	if not is_on_floor():
		var gravity = get_gravity() * gravity_multiplier
		velocity += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	anim.play("idle")
	move_and_slide()


# 💥 Allow other scripts (like Area2D) to modify gravity multiplier
func set_gravity_multiplier(value: float) -> void:
	gravity_multiplier = value
