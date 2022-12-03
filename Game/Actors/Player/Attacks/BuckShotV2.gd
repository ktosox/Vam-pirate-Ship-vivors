extends Shooter

func _init():
	damage = 6
	cooldown = 5.0
	bulletScene = load("res://Actors/Player/Attacks/Shot.tscn")
