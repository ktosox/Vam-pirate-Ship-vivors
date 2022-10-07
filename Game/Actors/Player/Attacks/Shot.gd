extends Area2D

var damage = 6.0

var speed = 500



var spread = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	global_position += Vector2(1,0).rotated(global_rotation + spread) * delta * speed


func _on_OrphaneTimer_timeout():
	queue_free()
	pass # Replace with function body.
