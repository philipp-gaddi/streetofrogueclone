extends Node2D

var bullet = preload("res://weapon/ShotgunBullet.tscn")
var fire_rate_in_s = .4
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func shoot(aim_direction):
	if can_shoot:
		
		var new_bullet = bullet.instance()
		new_bullet.direction = aim_direction.normalized()
		new_bullet.position = new_bullet.position + new_bullet.direction * 20.0
		add_child(new_bullet)
		can_shoot = false
		yield(get_tree().create_timer(fire_rate_in_s, false), "timeout")
		can_shoot = true
	



