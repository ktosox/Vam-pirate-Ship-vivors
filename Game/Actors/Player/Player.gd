extends RigidBody2D

#var maxTurn = 20
#
#var maxMove = 6


func _ready():
	$Label.set_as_toplevel(true)

func _physics_process(delta):
	linear_velocity += max(int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down")),-0.2) * Vector2(0,-390).rotated(rotation) * delta * ( (linear_velocity.length_squared() + 1) / (linear_velocity.length_squared() + 40) )

	angular_velocity += (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))) * ( linear_velocity.length() / (linear_velocity.length()+2) ) * 2 * delta
	
	$Label.rect_position = global_position + Vector2(-32,32)
	$Label.text = "Angular: " + str(angular_velocity) + " / Linear: " + str(linear_velocity)
	pass
