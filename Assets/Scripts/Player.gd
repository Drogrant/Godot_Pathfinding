
export var health = 100
export var hunger = 100
export var speed = 75
export var wayp_err = 1.0

var current_wayp setget ,get_current_wayp
var next_wayp setget ,get_next_wayp
var path setget new_path, get_path

signal wayp_reached

func _ready():
	self.set_fixed_process(false)

func _fixed_process(delta):
	self.global_translate((next_wayp-current_wayp).normalized()*delta*speed)
	if ((self.get_global_pos()-next_wayp).length() <= wayp_err):
		self.emit_signal("wayp_reached")

func proceed_path():
	self.set_fixed_process(true)
	while(path.size() > 0):
		current_wayp = self.get_global_pos()
		next_wayp = path[0]
		path.remove(0)
		yield(self,"wayp_reached")
	self.set_fixed_process(false)

func new_path(new_path = []):
	path = new_path
	if (!self.is_fixed_processing()):
		self.proceed_path()
	else:
		emit_signal("wayp_reached")

func get_current_wayp():
	return current_wayp

func get_next_wayp():
	return next_wayp

func get_path():
	return path

