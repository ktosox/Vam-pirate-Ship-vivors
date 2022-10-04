extends Node2D

var spawnDistance = Vector2(0,500)

var enemyScene = preload("res://Actors/Enemies/Enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func pick_location(): #in local cords
	var spawnPoint = Vector2.ZERO
	spawnPoint += spawnDistance
	spawnPoint = spawnPoint.rotated(global_rotation + (randf()-0.5)*5.0 )
	spawnPoint *= 0.3 + (randf()*0.4)
	return spawnPoint


func spawn_enemy():
	var enemy = enemyScene.instance()
	enemy.global_position = global_position + pick_location()
	get_parent().get_parent().add_child(enemy)
	pass
