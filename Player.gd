extends CharacterBody2D


const SPEED = 300
const ACCELERATION = 200
const MAXSPEED = 350
const JUMP_VELOCITY = -400.0
const FRICTION = 300
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



@onready var animationPlayer = $animationPlayer
@onready var animationTree = $AnimationTree

func _ready():
	pass
	
func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", input)
		animationTree.set("parameters/run/blend_position", input)
		velocity = velocity.move_toward(input * MAXSPEED, ACCELERATION * delta)
#		velocity += input * SPEED * delta
#		velocity = velocity.limit_length(MAXSPEED)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()


