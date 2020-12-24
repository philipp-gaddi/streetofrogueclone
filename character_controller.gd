extends KinematicBody2D

var velocity = Vector2()

func _physics_process(delta):
	
	move_and_slide(velocity)

func _process(delta):
	# the direction up, down, left, right which is most similar to velocity
	# direction, via dot product. To decide which animation should be played
	if velocity == Vector2.ZERO:
		$AnimatedSprite.stop()
		$AudioStreamPlayer2D.stop()
		
		# todo idle stand animation, maybe dependend on direction?
		return
	
	var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	var cosines = []
	var velocity_normed = velocity.normalized()
	for d in directions:
		cosines.append(velocity.dot(d))
	
	var maximum_index = 0
	var maximum_value = -99.0
	for i in range(cosines.size()):
		if cosines[i] > maximum_value:
			maximum_value = cosines[i]
			maximum_index = i
	
	if maximum_index == 0:
		$AnimatedSprite.play("walk_up")
	elif maximum_index == 1:
		$AnimatedSprite.play("walk_down")
	elif maximum_index == 2:
		$AnimatedSprite.play("walk_left")
		$AudioStreamPlayer2D.play()
	elif maximum_index == 3:
		$AnimatedSprite.play("walk_right")
		$AudioStreamPlayer2D.play()


# implement here all behaviors this character can doZ
