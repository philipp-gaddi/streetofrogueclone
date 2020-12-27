extends StaticBody2D

var closed_tex = preload("res://tileset/door_tile_north_closed.png")
var opened_tex = preload("res://tileset/door_tile_north_opened.png")
var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func interact():
	
	if open:
		open = false
		$Sprite.texture = closed_tex
		$CollisionShape2D.disabled = false
		$audio_close.play()
	else:
		open = true
		$Sprite.texture = opened_tex
		$CollisionShape2D.disabled = true
		$audio_open.play()
