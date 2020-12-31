extends Sprite


var shootable = preload("res://weapon/shotgun.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func collected():
	visible = false
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, "finished")
	queue_free()
	

