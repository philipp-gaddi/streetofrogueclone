extends Node2D
# Human Intelligence
var character

func _ready():
	
	character = $".."



func _process(_delta):
	var direction = Vector2()
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	
	character.set_velocity_direction(direction.normalized())
	
	if Input.is_action_just_pressed("interact"):
		character.interact()
	
	if Input.is_action_just_pressed("shoot"):
		character.shoot(get_global_mouse_position() - character.get_global_position())
