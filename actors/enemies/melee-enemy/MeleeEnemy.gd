extends "res://actors/enemies/Enemy.gd"

export var knock_back_force : float
export var attack_distance : float

func _physics_process(delta : float) -> void:
	if player == null:
		return
	
	var direction = player.global_transform.origin - global_transform.origin
	direction.y = 0
	direction = direction.normalized()
	
	move_and_slide(direction * move_speed, Vector3(0, 1, 0))
	if player.global_transform.origin.distance_to(global_transform.origin) < attack_distance and timer.is_stopped():
		timer.start()
		player.take_damage(damage,knock_back_force)

