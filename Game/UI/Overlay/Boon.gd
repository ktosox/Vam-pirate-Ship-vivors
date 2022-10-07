extends Button

var ID



func load_data(boon : Boon):
	
	$Layout/Name.text = boon.name
	$Layout/Description.bbcode_text = "[center]" + boon.description
	$Layout/Icon.texture = boon.icon
	pass

func _on_Boon_pressed():
	GM.do_a_boon($Layout/Name.text)
	get_parent().get_parent().queue_free()
	pass # Replace with function body.
