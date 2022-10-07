extends Area2D

var shotScene = preload("res://Actors/Player/Attacks/Shot.tscn")

var canShoot = true

var shootCount = 3

var damage = 6.0

func fire():
	$AudioStreamPlayer2D.pitch_scale = randf()*0.12 + 0.7
	$AudioStreamPlayer2D.play()
	var targetList = get_overlapping_areas() as Array
	assert(targetList.size()>0)
	look_at(targetList[randi()%targetList.size()].global_position)
	for z in shootCount:
		var shot = shotScene.instance()
		shot.damage = damage
		shot.spread = 0.04 * stepify(z,2) * ( 1 - (z%2) * 2 )
		print(shot.spread)
		shot.global_position = global_position
		shot.global_rotation = global_rotation
		shot.set_as_toplevel(true)
		get_parent().call_deferred("add_child",shot)
	canShoot = false
	$ReloadTimer.start()
	pass


func _on_Buckshot_area_entered(area):
	if canShoot:
		fire()
	pass # Replace with function body.



func _on_ReloadTimer_timeout():
	canShoot = true
	if get_overlapping_areas().size()>0:
		fire()
	pass # Replace with function body.
