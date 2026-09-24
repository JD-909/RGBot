extends Camera2D

@export var move_speed = 0.5
@export var zoom_speed = 0.05
@export var min_zoom = 1
@export var max_zoom = 3
@export var margin = Vector2(300, 200)

var targets : Array[Node] = []

@onready var screen_size = get_viewport_rect().size

func add_target(t : Node) -> void:
	if not t in targets:
		targets.append(t)

func remove_target(t : Node) -> void:
	if t in targets:
		targets.erase(t)

func _process(_delta: float) -> void:
	
	# si no hay targets, vuelve
	if !targets:
		return
	
	# para mantener la camara centrada entre los targets
	# p es un punto que esta entre las posiciones de los targets
	var p = Vector2.ZERO
	for target in targets:
		p += target.global_position
	p /= targets.size()
	global_position = lerp(global_position, p, move_speed)
	
	# para un zoom q contenga los targets
	# r es un rectangulo q contiene a los targets (+ un margen) con centro p
	var r = Rect2(global_position, Vector2.ONE)
	for target in targets:
		r = r.expand(target.global_position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	
	var z
	if r.size.x > r.size.y * screen_size.aspect():
		z = clamp(r.size.x / screen_size.x, min_zoom, max_zoom)
	else:
		z = clamp(r.size.y / screen_size.y, min_zoom, max_zoom)
	# mayor z, mas lejos esta la camara
	zoom = lerp(zoom, Vector2.ONE / z, zoom_speed)
