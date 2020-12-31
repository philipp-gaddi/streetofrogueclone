extends RigidBody2D


var direction = null
var speed_pps = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_impulse(Vector2(), direction * speed_pps)
	self.rotation = direction.angle()
	

func _on_Timer_timeout():
	queue_free()
	
