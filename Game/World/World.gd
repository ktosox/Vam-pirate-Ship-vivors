extends Node2D

var waterChunks = [{},{},{},{}]

var landChunks = [{},{},{}]

var ratio = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var water1 = load("res://World/Chunks/WaterChunk1.tscn").instance() as TileMap
	for T in water1.get_used_cells():
		waterChunks[0][T] = water1.get_cellv(T)
	var water2 = load("res://World/Chunks/WaterChunk2.tscn").instance() as TileMap
	for T in water2.get_used_cells():
		waterChunks[1][T] = water2.get_cellv(T)
	var water3 = load("res://World/Chunks/WaterChunk3.tscn").instance() as TileMap
	for T in water3.get_used_cells():
		waterChunks[2][T] = water3.get_cellv(T)
	var water4 = load("res://World/Chunks/WaterChunk4.tscn").instance() as TileMap
	for T in water4.get_used_cells():
		waterChunks[3][T] = water4.get_cellv(T)
	var land1 = load("res://World/Chunks/LandChunk1.tscn").instance() as TileMap
	for T in land1.get_used_cells():
		landChunks[0][T] = land1.get_cellv(T)
	var land2 = load("res://World/Chunks/LandChunk2.tscn").instance() as TileMap
	for T in land2.get_used_cells():
		landChunks[1][T] = land2.get_cellv(T)
	var land3 = load("res://World/Chunks/LandChunk3.tscn").instance() as TileMap
	for T in land3.get_used_cells():
		landChunks[2][T] = land3.get_cellv(T)
	pass # Replace with function body.


func load_chunk(topLeftCorner : Vector2):
	
	# load a random chunk (based on ratio)
	# (randf() - 0.5) + ratio / > 0 make water / < 0 make land
	# 
	# if land added ratio += 0.5
	# if water added ratio -= 0.1
	var chunk
	if 1.6 * (randf() - 0.5) + ratio > 0 :
		chunk = waterChunks[randi()%waterChunks.size()].duplicate()
		ratio -= 0.1
	else:
		chunk = landChunks[randi()%landChunks.size()].duplicate()
		ratio += 0.3
	var flipper = Vector2(-1 + 2 * (randi()%2),-1 + 2*(randi()%2) )
	for T in chunk:
		var test = T
		if flipper.x == -1 :
			test.x = (T.x - 9) * -1
		if flipper.y == -1 :
			test.y = (T.y - 9) * -1
		$TileMap.set_cellv(topLeftCorner+T,chunk[test] )
	$TileMap.update_bitmask_region(topLeftCorner, topLeftCorner + Vector2(9,9))

func _on_ChunkTimer_timeout():
	#get player position in chunk cords
	var playerTile = $TileMap.world_to_map(GM.player.global_position) + Vector2(-5,-5)
	var playerChunk = Vector2(round(playerTile.x/10),round(playerTile.y/10))
#	print(playerTile," -> ",playerChunk)
	for X in range(-4,5):
		for Y in range(-3,4):
			if $TileMap.get_cellv( (playerChunk + Vector2(X,Y)) * 10 ) == -1:
				load_chunk((playerChunk + Vector2(X,Y)) * 10 )

	pass # Replace with function body.
