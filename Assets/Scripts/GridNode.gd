var ID setget ,get_ID  #Identifier of the Node
var global_pos setget separation_changed, get_global_pos #Node position in the world
var neighbours = [] setget asign_neighbours, get_neighbours #Closest nodes to the current one, there could be 8 or 4 neighbours depending on the settings

var cost = 0

#Class constructor
func _init(id, separation, dimensions, is_4or8):
	ID = id
	separation_changed(separation)
	asign_neighbours(dimensions,is_4or8)

#When the neighbours needs to be recalculated, call this function.
func asign_neighbours(dimensions,so_is_4or8):
	neighbours = []
	if(so_is_4or8):
		calc_4xneighbours(dimensions)
	else:
		calc_8xneighbours(dimensions)

#If 4-connection grid is enabled then this function calculates the neighbours.
func calc_4xneighbours(grid_dimensions):
	for i in [ID.x-1, ID.x+1]:
		if (i < 0 || i >= grid_dimensions.x):
			continue
		neighbours.append(Vector2(i,ID.y))
	for j in [ID.y-1, ID.y+1]:
		if (j < 0 || j >= grid_dimensions.y):
			continue
		neighbours.append(Vector2(ID.x,j))

#If 8-connection grid is enabled then this function calculates the neighbours.
func calc_8xneighbours(grid_dimensions):
		for i in range(ID.x-1, ID.x+2):
			if (i < 0 || i >= grid_dimensions.x):
				continue
			for j in range(ID.y-1, ID.y+2):
				if (j < 0 || j >= grid_dimensions.y || (i == ID.x && j == ID.y)):
					continue
				neighbours.append(Vector2(i,j))

#When the distance between nodes changes, with this node the global position can be recalculated.
func separation_changed(new_separation):
	global_pos = Vector2(ID.x*new_separation,ID.y*new_separation)

func get_ID():
	return ID

func get_global_pos():
	return global_pos

func get_neighbours():
	return neighbours