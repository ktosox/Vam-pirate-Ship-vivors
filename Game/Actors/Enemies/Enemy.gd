extends Node2D

var lootScene = preload("res://Actors/Loot/Loot.tscn")

var healthPoints = 10.0

var speed = 50

onready var target = GM.player as Node2D

func _ready():
	set_physics_process(false)


func _physics_process(delta):
	global_position = global_position.move_toward(target.global_position, delta * speed)
	pass


func start():
	$HiBox/CollisionShape2D.set_deferred("disabled",false)
	if target == null:
		var dummy = Node2D.new()
		dummy.set_as_toplevel(true)
		dummy.global_position = get_global_mouse_position()
		get_parent().call_deferred("add_child",dummy)
		target = dummy
	set_physics_process(true)
	pass

func die():
	set_physics_process(false)
	$Blood.emitting = true
	$Sprite.visible = false
	var drop = lootScene.instance()
	drop.global_position = global_position
	get_parent().call_deferred("add_child",drop)
	$HiBox.call_deferred("queue_free")
	yield(get_tree().create_timer(1.0),"timeout")
	queue_free()
	pass

func _on_HiBox_area_entered(area):
	die()
	pass # Replace with function body.
