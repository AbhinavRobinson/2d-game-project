extends KinematicBody2D

const UP = Vector2(0,-1)

# SPEED of player
export var SPEED = 200.0
export var JUMP_HEIGHT = 350.0
export var GRAVITY = 10.0

# screen size of window
var SCREEN_SIZE = Vector2.ZERO

# Create Motion State
var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	# get screen size
	SCREEN_SIZE = get_viewport_rect().size
	$AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	motion.y += GRAVITY
	
	# get player input X
	if Input.is_action_pressed("move_right"):
		motion.x = 1.0*SPEED
	elif Input.is_action_pressed("move_left"):
		motion.x = -1.0*SPEED
	# get player input Y
	#if Input.is_action_pressed("move_down"):
	#	direction.y += 1
	else:
		motion.x = 0.0 
		
	if is_on_floor():
		if Input.is_action_just_pressed("move_up"):
			motion.y = -JUMP_HEIGHT
	
	# move player
	motion = move_and_slide(motion, UP)
	
	# limit player to screen
	position.x = clamp(position.x, 0, SCREEN_SIZE.x)
	position.y = clamp(position.y, 0 ,SCREEN_SIZE.y)
	
	# give animation direction (left/right/up/down)
	if motion.x != 0 and is_on_floor():
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = motion.x < 0
	else:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.flip_h = motion.x < 0
	
	if not is_on_floor():
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.flip_h = motion.x < 0
