extends CharacterBody2D

const SPEED = 250
const ACCELERATION = 150
const MAXSPEED = 300
const JUMP_VELOCITY = -400.0
const FRICTION = 550

enum { # 0 ,1 ,1, 3....
	MOVE, ROLL, ATTACK
}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Vector2.ZERO
var state = MOVE
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	
func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)
			
	

func move_state(delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	#dampen the slide on released keys
#	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
#		velocity.y *= 0.01
#	elif Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
#		velocity.x *= 0.01
		
	if direction != Vector2.ZERO:

		animationTree.set("parameters/walk/blend_position", direction)
		animationTree.set("parameters/idle/blend_position", direction)
		animationTree.set("parameters/attack/blend_position", direction)
		animationState.travel("walk")
		velocity += direction * SPEED * delta
		velocity = velocity.limit_length(MAXSPEED)
	else: 
		animationState.travel("idle")
		
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	move_and_slide()
	
func attack_state(delta):
	animationState.travel("attack")
	
func attack_animation_finished():
	state = MOVE
	velocity = Vector2.ZERO
	

#func is_moving(value):
#
#	animationTree["parameters/conditions/idle"] = not value
#	animationTree["parameters/conditions/is_walking"] = value
#
#func update_blend_position():
##	animationTree["parameters/idle/blend_position"] = direction
#	animationTree.set("parameters/walk/blend_position", direction)
#	animationTree.set("parameters/idle/blend_position", direction)
	
