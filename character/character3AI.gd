extends Node2D


onready var character = $'..'
var path : PoolVector2Array
var navigation : Navigation2D

var is_following = false
var is_seeing_player = false

var target = null


# Called when the node enters the scene tree for the first time.
func _ready():
	
	character.shootable = preload("res://weapon/shotgun.gd").new()
	character.call_deferred('add_child', character.shootable)
	set_process(false)


func _process(delta):
	
	
	
	if is_seeing_player:
		character.shoot(target.get_global_position() - character.get_global_position())
	elif is_following:
		var move_vel = Vector2()
		var next_point = path[0]
		
		# else condition also terminate following
		if path.size() > 1:
			if character.get_global_position().distance_to(next_point) < 10:
				path.remove(0)
				next_point = path[0]
			move_vel = next_point - character.get_global_position()
		elif character.get_global_position().distance_to(next_point) > 10:
			move_vel = next_point - character.get_global_position()
		else:
			is_following = false
			set_process(false)
		
		character.set_velocity_direction(move_vel.normalized())



func _on_Vision_body_entered(body):
	if body.is_in_group('human'):
		print('player sighted')
		is_seeing_player = true
		is_following = false
		target = body
		set_process(true)


# rough, i just wanted to get something work, no checks, etc.
func _on_Vision_body_exited(body):
	if body.is_in_group('human'):
		print('lost sight of player')
		is_seeing_player = false
		path = navigation.get_simple_path(character.get_global_position(), body.get_global_position())
		is_following = true

