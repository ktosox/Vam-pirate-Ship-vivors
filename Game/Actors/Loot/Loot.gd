extends RigidBody2D

var value = 15

func nom():
	$CollisionShape2D.set_deferred("disabled",true)
	$CPUParticles2D.emitting = false
	yield(get_tree().create_timer(1.0),"timeout")
	queue_free()
