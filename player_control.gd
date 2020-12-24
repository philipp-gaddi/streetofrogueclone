extends Node

var animationsprite
var character

var speed_pps = 10

func _ready():
	
	character = $".."
	animationsprite = $"../AnimatedSprite"



func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed_pps
	if Input.is_action_pressed("move_right"):
		velocity.x += speed_pps
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed_pps
	if Input.is_action_pressed("move_down"):
		velocity.y += speed_pps
	
	character.velocity = velocity
	
	
	

