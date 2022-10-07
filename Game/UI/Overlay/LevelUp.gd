extends CanvasLayer

func _ready():
	get_tree().paused = true
	var selectedBoons = GM.availableBoons.duplicate() as Array
	while selectedBoons.size() > 3 :
		selectedBoons.remove(randi()%selectedBoons.size())
	$Layout/Boon.load_data(GM.ID_to_boon(selectedBoons[1]) )
	$Layout/Boon2.load_data(GM.ID_to_boon(selectedBoons[0]))
	$Layout/Boon3.load_data(GM.ID_to_boon(selectedBoons[2]))


func _exit_tree():
	get_tree().paused = false
