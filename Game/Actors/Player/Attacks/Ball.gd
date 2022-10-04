extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	global_position += Vector2(1,0).rotated(global_rotation) * delta * speed


func _on_OrphaneTimer_timeout():
	queue_free()
	pass # Replace with function body.
