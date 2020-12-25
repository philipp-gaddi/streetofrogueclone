extends KinematicBody2D

# input from "outside" the velocity to control movement
# assume it's normalized
var velocity = Vector2()
var direction = Vector2()
var speed_pp = 20

# interns
var state_machine:AnimationNodeStateMachinePlayback

func _ready():
	$AnimationTree['parameters/idle/blend_position'] = Vector2.DOWN
	$AnimationTree['parameters/walk/blend_position'] = Vector2.DOWN
	state_machine = $AnimationTree['parameters/playback']
	state_machine.start('idle')

func _physics_process(_delta):
	
	# TODO handle collisions, damage, push back etc.
	move_and_slide(velocity)

func _process(_delta):
	
	if velocity == Vector2.ZERO:
		state_machine.travel('idle')
	else:
		$AnimationTree['parameters/idle/blend_position'] = direction
		$AnimationTree['parameters/walk/blend_position'] = direction
		state_machine.travel('walk')
	

func set_velocity_direction(_direction:Vector2):
	direction = _direction
	velocity = _direction * speed_pp

# implement here all behaviors this character can doZ
