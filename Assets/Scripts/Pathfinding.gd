onready var player = get_node("Phys_Player")
onready var input = preload("In_game_input.gd").new()
onready var grid_node = get_node("Grid")

func _ready():
	self.set_process_input(true)
	input.handler = self

func _input(event):
	input.input(event)

func _draw():
	pass

func A_star(start_position, end_position):
	var closed_list = []
	var open_list = [grid_node.closest_point(start_position)]
	grid_node.grid[open_list[0].x][open_list[0].y].cost = 0
	var goal = grid_node.closest_point(end_position)
	var cost = 0
	while(open_list[0] != goal):
		var current_node = grid_node.grid[open_list.front().x][open_list.front().y]
		closed_list.append(open_list.front())
		open_list.pop_front()
		for neighbour in current_node.get_neighbours():
			cost = current_node.cost + 1
			if(neighbour in open_list && cost < grid_node.grid[neighbour.x][neighbour.y].cost):
				open_list.erase(neighbour)
			elif (neighbour in closed_list && cost < grid_node.grid[neighbour.x][neighbour.y].cost):
				closed_list.erase(neighbour)
			else
		break