tool #Execute it in the editor to visualize the grid
extends CanvasItem #To draw in the editor the script needs to inherit from CanvasItem

export var separation = 50 setget set_new_separation #Separation between nodes
export var is_4or8 = true setget set_4or8 #if true then diagonal connections are disabled
export var dimensions = Vector2(2,2) setget resize_grid #The first element represents horizontal position and the second vertical placement

#Load the node script
var grid_node_class = preload("GridNode.gd")
onready var input = preload("In_game_input.gd").new()

var grid = []

var id_estimation = Vector2(0,0)

#This function empties the grid and creates a new one with the updated dimensions
func resize_grid(new_dimensions):
	grid = []
	for i in range(0, new_dimensions.x):
		grid.append([])
		for j in range(0, new_dimensions.y):
			grid[i].append(grid_node_class.new(Vector2(i,j),separation,new_dimensions,is_4or8))
	dimensions = new_dimensions
	update()

#Here one changes the distance between nodes and updates the nodes
func set_new_separation(new_separation):
	separation = new_separation
	for row in grid:
		for node in row:
			node.global_pos = separation
	update()

#Function to switch 4 to 8 connections
func set_4or8(is4then):
	is_4or8 = is4then
	for row in grid:
		for node in row:
			node.asign_neighbours(dimensions,is_4or8)
	update()

#Given a point in the space it returns the closes point in the grid
func closest_point(global_pos_target):
	id_estimation = Vector2(convert(global_pos_target.x/separation,2), convert(global_pos_target.y/separation,2))
	var distance = id_estimation.length()*separation
	for l in range(0,2):
		id_estimation[l] = min(id_estimation[l],dimensions[l]-2)
		id_estimation[l] = max(id_estimation[l],0)
	var temp = 0
	var ids_to_check = id_estimation
	for i in [ids_to_check.x, ids_to_check.x + 1]:
		for j in [ids_to_check.y, ids_to_check.y + 1]:
			temp = (global_pos_target - grid[i][j].get_global_pos()).length()
			if (temp < distance):
				distance = temp
				id_estimation = Vector2(i,j)
	update()
	return id_estimation

#Custom draw to display the grid in the editor
func _draw():
	for row in grid:
		for node in row:
			draw_circle(node.global_pos,5,Color(1,1,1))
			for ids in node.neighbours:
				draw_line(node.global_pos,grid[ids.x][ids.y].global_pos,Color(1,1,1))
	draw_circle(grid[id_estimation.x][id_estimation.y].global_pos,5,Color(1,0,0))






