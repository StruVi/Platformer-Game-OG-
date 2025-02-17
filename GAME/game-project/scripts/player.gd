extends CharacterBody2D

@export var speed = 100
@export var jump_force = -350
var gravity = 1200
var move_direction = 0  # Used for touch movement
var left_pressed = false
var right_pressed = false

func _ready():
	var touch_controls = get_node_or_null("/root/GameScene/TouchControls")  # Ensure correct path

	if touch_controls:
		print("TouchControls found!")

		# Connect signals from touch_controls
		touch_controls.move_left_pressed.connect(_on_left_pressed)
		touch_controls.move_left_released.connect(_on_left_released)
		touch_controls.move_right_pressed.connect(_on_right_pressed)
		touch_controls.move_right_released.connect(_on_right_released)
		touch_controls.jump_pressed.connect(_on_jump_pressed)  # Connect jump button
	else:
		print("ERROR: TouchControls not found!")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle keyboard movement separately
	var keyboard_direction = Input.get_axis("ui_left", "ui_right")

	if keyboard_direction != 0:
		move_direction = keyboard_direction  # Only update if a key is pressed
	elif not left_pressed and not right_pressed:
		move_direction = 0  # Stop movement if no key or touch input is active

	# Handle jumping (keyboard support)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_on_jump_pressed()

	# Flip player sprite based on direction
	if move_direction != 0:
		$AnimatedSprite2D.flip_h = move_direction < 0  # Flip when moving left

	# Apply movement
	velocity.x = move_direction * speed
	move_and_slide()

	

func _on_left_pressed():
	move_direction = -1
	left_pressed = true
	print("Left Button Pressed!")

func _on_left_released():
	left_pressed = false
	if not right_pressed:
		move_direction = 0  # Stop only if the right button isn’t pressed
	print("Left Button Released!")

func _on_right_pressed():
	move_direction = 1
	right_pressed = true
	print("Right Button Pressed!")

func _on_right_released():
	right_pressed = false
	if not left_pressed:
		move_direction = 0  # Stop only if the left button isn’t pressed
	print("Right Button Released!")

func _on_jump_pressed():
	if is_on_floor():
		velocity.y = jump_force  # Apply jump force
		print("Jumping!")
