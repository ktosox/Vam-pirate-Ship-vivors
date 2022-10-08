extends Button

var ID

func _input(event):
	if has_focus() and event.is_action_pressed("ui_accept"):
		_on_Boon_pressed()

func load_data(boon : Boon):
	$Layout/Name.text = boon.name
	$Layout/Description.bbcode_text = "[center]" + boon.description
	$Layout/Icon.texture = boon.icon
	pass

func _on_Boon_pressed():
	
	get_parent().get_parent().boon_selected($Layout/Name.text)
	pass # Replace with function body.
