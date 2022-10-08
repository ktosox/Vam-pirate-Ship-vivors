extends CanvasLayer

var spent = false

func _ready():
	get_tree().paused = true
	var selectedBoons = GM.availableBoons.duplicate() as Array
	while selectedBoons.size() > 3 :
		selectedBoons.remove(randi()%selectedBoons.size())
	$Layout/Boon.load_data(GM.ID_to_boon(selectedBoons[1]) )
	$Layout/Boon2.load_data(GM.ID_to_boon(selectedBoons[0]))
	$Layout/Boon3.load_data(GM.ID_to_boon(selectedBoons[2]))


func boon_selected(name):
	if !spent:
		spent = true
	else:
		return
	GM.do_a_boon(name)
	$AnimationPlayer.play("New Anim")
	pass


func _input(event):
	if spent:
		return
	if event.is_action_pressed("ui_up"):
		$Layout/Boon2.call_deferred("grab_focus")
	if event.is_action_pressed("ui_left"):
		$Layout/Boon.call_deferred("grab_focus")
	if event.is_action_pressed("ui_right"):
		$Layout/Boon3.call_deferred("grab_focus")
	
		

func _exit_tree():
	get_tree().paused = false
