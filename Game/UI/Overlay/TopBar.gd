extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("treasure_changed",self,"update_treasure")
	get_parent().connect("level_up", self, "level_up")
	pass # Replace with function body.


func level_up():
	print("ding!")
	pass

func update_treasure(newTreasure):
	$Layout/TreasureBar.value = newTreasure
	pass


func _on_Menu_pressed():
	print("menu")
	pass # Replace with function body.
