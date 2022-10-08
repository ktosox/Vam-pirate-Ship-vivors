extends RigidBody2D

class_name Player

var levelUpScene = preload("res://UI/Overlay/LevelUp.tscn")

var health = 100

var regen = 0.0

var treasure = 0

var speed = 350

var armor = 1.0

var dings = 0

signal health_changed(newHealth)

signal treasure_changed(newTreasure)

signal level_up


func _ready():
	$Label.set_as_toplevel(true)
	GM.player = self

func _physics_process(delta):
	linear_velocity += max(int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down")),-0.2) * Vector2(0,-speed).rotated(rotation) * delta * ( (linear_velocity.length_squared() + 1) / (linear_velocity.length_squared() + 40) )

	angular_velocity += (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))) * ( linear_velocity.length() / (linear_velocity.length()+20) ) * 2 * delta
	
	$Label.rect_position = global_position + Vector2(-32,-20)
	$Label.text = "Angular: " + str(angular_velocity) + " / Linear: " + str(linear_velocity)
	$ViewportContainer/Viewport/Galeon.rotation.z = angular_velocity * 0.4
	health += regen * delta
	health = min(health,100)

func damage(amount):
	health -= (amount * armor)
	emit_signal("health_changed",health)
	if health < 1:
		var deathScreen = load("res://UI/Overlay/GameOver.tscn")
		add_child(deathScreen.instance())
		get_tree().paused = true
	pass

func _on_LootEater_body_entered(body):
	assert(body.has_method("nom"))
	treasure += body.value * ( 10.0 /(dings + 9.0) )
	if treasure >= 100 :
		emit_signal("level_up")
		var ding = levelUpScene.instance()
		get_parent().add_child(ding)
		treasure -= 100
		dings += 1
	emit_signal("treasure_changed", treasure)
	body.nom()
		

func _exit_tree():
	if GM.player == self:
		GM.player = null


func _on_HitBox_area_entered(area):
	damage(10)
	pass # Replace with function body.


func _on_RandomHealthUpdate_timeout():
	emit_signal("health_changed",health)
	pass # Replace with function body.
