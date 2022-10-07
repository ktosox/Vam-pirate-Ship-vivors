extends Area2D

var ballScene = preload("res://Actors/Player/Attacks/Ball.tscn")

var canShoot = true

var damage = 11.0

func fire():
	$AudioStreamPlayer2D.pitch_scale = randf()*0.22 + 0.6
	$AudioStreamPlayer2D.play()
	var targetList = get_overlapping_areas() as Array
	assert(targetList.size()>0)
	var ball = ballScene.instance()
	ball.damage = damage
	look_at(targetList[randi()%targetList.size()].global_position)
	ball.global_position = global_position
	ball.global_rotation = global_rotation
	ball.set_as_toplevel(true)
	get_parent().call_deferred("add_child",ball)
	canShoot = false
	$ReloadTimer.start()
	pass

func _on_Cannon_area_entered(area):
	if canShoot:
		fire()
	pass # Replace with function body.


func _on_ReloadTimer_timeout():
	canShoot = true
	if get_overlapping_areas().size()>0:
		fire()
	pass # Replace with function body.
