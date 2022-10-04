extends RigidBody2D

var health = 100

var treasure = 0

signal health_changed(newHealth)

signal treasure_changed(newTreasure)

signal level_up


func _ready():
	$Label.set_as_toplevel(true)
	GM.target = self

func _physics_process(delta):
	linear_velocity += max(int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down")),-0.2) * Vector2(0,-390).rotated(rotation) * delta * ( (linear_velocity.length_squared() + 1) / (linear_velocity.length_squared() + 40) )

	angular_velocity += (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))) * ( linear_velocity.length() / (linear_velocity.length()+20) ) * 2 * delta
	
	$Label.rect_position = global_position + Vector2(-32,-20)
	$Label.text = "Angular: " + str(angular_velocity) + " / Linear: " + str(linear_velocity)


func damage(amount):
	health -= amount
	emit_signal("health_changed",health)
	if health < 0:
		print("guess I'll die :(")
	pass

func _on_LootEater_body_entered(body):
	assert(body.has_method("nom"))
	treasure += body.value
	if treasure >= 100 :
		emit_signal("level_up")
		treasure -= 100
	emit_signal("treasure_changed", treasure)
	body.nom()
		

func _exit_tree():
	if GM.target == self:
		GM.target = null


func _on_HitBox_area_entered(area):
	damage(10)
	pass # Replace with function body.
