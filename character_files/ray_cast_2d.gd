extends RayCast2D

var laser_speed = 1000
var laser_on : bool = true

func _physics_process(_delta: float) -> void:
	if laser_on:
		if is_colliding():
			$LaserLine.points[1].x = global_position.distance_to(get_collision_point())/2 +16
		else:
			$LaserLine.points[1].x = target_position.x
		
		$LaserLine/Area2D/CollisionShape2D.shape.b.x = $LaserLine.points[1].x -16

func toggle() -> void:
	laser_on = !laser_on
	$LaserLine.visible = !$LaserLine.visible
	$LaserLine/Area2D/CollisionShape2D.disabled = !$LaserLine/Area2D/CollisionShape2D.disabled
