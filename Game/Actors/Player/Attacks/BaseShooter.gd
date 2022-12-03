class_name Shooter

extends Area2D

var bulletScene

var canShoot = true

var damage = 0.0

var cooldown = 3.0

func _ready():
	assert(bulletScene!=null)
	$ReloadTimer.wait_time = cooldown

func fire():
	$Bang.pitch_scale = randf()*0.22 + 0.6
	$Bang.play()
	var targetList = get_overlapping_areas() as Array
	assert(targetList.size()>0)
	var bullet = bulletScene.instance()
	bullet.damage = damage
	look_at(targetList[randi()%targetList.size()].global_position)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	bullet.set_as_toplevel(true)
	get_tree().current_scene.call_deferred("add_child",bullet)
	canShoot = false
	$ReloadTimer.start()


func _on_Cannon_area_entered(area):
	if canShoot:
		fire()


func _on_ReloadTimer_timeout():
	canShoot = true
	if get_overlapping_areas().size()>0:
		fire()
