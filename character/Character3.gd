extends KinematicBody2D

# input from "outside" the velocity to control movement
# assume it's normalized
var velocity = Vector2()
var direction = Vector2()
var speed_pp = 40
var interactable = null
var shootable = null 

# interns
var state_machine:AnimationNodeStateMachinePlayback
var idle_state:AnimationNodeAnimation

func _ready():
	$AnimationTree['parameters/idle/blend_position'] = Vector2.DOWN
	$AnimationTree['parameters/walk/blend_position'] = Vector2.DOWN
	state_machine = $AnimationTree['parameters/playback']
	state_machine.start('idle')
	

func _physics_process(_delta):
	
	# TODO handle collisions, damage, push back etc.
	var col = move_and_slide(velocity) 
#	var col = move_and_collide(velocity * _delta)


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

func interact():
	if interactable == null:
		return
	
	interactable.interact()

func shoot(aim_direction:Vector2):
	if shootable == null:
		return
	print(aim_direction)
	shootable.shoot(aim_direction)
	


func _on_Interaktionradius_area_entered(area):
	# todo: what if two interactable, three etc. probably have to be more precise, raycasting
	# or list
	
	if  interactable == null and area.is_in_group('interactable'):
		interactable = area.get_parent() # convention haha, implement checks
	elif shootable == null and area.is_in_group('shootable'):
		self.shootable = area.get_parent().shootable.new()
		area.get_parent().collected()
		add_child(self.shootable)


func _on_Interaktionradius_area_exited(area):
	if area.is_in_group('interactable') and interactable == area.get_parent():
		interactable = null
