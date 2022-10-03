extends TextureProgress



func _ready():
	set_as_toplevel(true)
	get_parent().connect("health_changed",self,"update_health")

func update_health(newHealth):
	value = newHealth
	pass


func _physics_process(delta):
	rect_position = get_parent().global_position + Vector2(-24,40)
