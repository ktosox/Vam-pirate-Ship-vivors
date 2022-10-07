extends Node

var player : Player

var availableBoons = range(7)

var enemyBoost = 0.0

func _init():
	randomize()

func _ready():
	_on_AudioStreamPlayer_finished()

func _process(delta):
	enemyBoost += 0.077 * delta

var songs = {-1:load("res://Resources/Music/Duet Musette.ogg"),1:load("res://Resources/Music/Miris Magic Dance.ogg")}

var currentSong = 0

func do_a_boon(name):
	match name:
		"Buckshot":
			availableBoons.erase(0)
			availableBoons.push_back(7)
			availableBoons.push_back(8)
			availableBoons.push_back(9)
			var buckShot = load("res://Actors/Player/Attacks/Buckshot.tscn")
			player.add_child(buckShot.instance())
			pass
		"Armor":
			player.armor *= 0.85
			pass
		"Repair":
			player.regen += 1.6
			pass
		"Move Speed":
			player.speed += 48
			pass
		"Turn Speed":
			player.angular_damp = 1.8
			availableBoons.erase(4)
			pass
		"Canon Damage":
			player.get_node("Cannon").damage += 3.0
			pass
		"Canon Speed":
			player.get_node("Cannon").get_node("ReloadTimer").wait_time *= 0.75
			pass
		"Buckshot Damage":
			player.get_node("Buckshot").damage += 1.2
			pass
		"Buckshot Speed":
			player.get_node("Buckshot").get_node("ReloadTimer").wait_time *= 0.84
			pass
		"Buckshot Size":
			player.get_node("Buckshot").shootCount += 1
			pass
	pass
	

func ID_to_boon(ID):
	return load("res://Resources/Boons/"+str(ID)+".tres")



func _on_AudioStreamPlayer_finished():
	if currentSong == 0 :
		currentSong = -1 + 2 * (randi()%2)
	currentSong *= -1
	print(currentSong)
	$AudioStreamPlayer.stream = songs[currentSong]
	yield(get_tree().create_timer(5.0),"timeout")
	$AudioStreamPlayer.play()
	pass # Replace with function body.


