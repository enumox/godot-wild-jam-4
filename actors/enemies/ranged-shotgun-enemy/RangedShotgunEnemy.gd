extends "res://actors/enemies/ranged-enemy/RangedEnemy.gd"

export var max_hit_distance : float
export var min_hit_distance : float
export(float, 0.1, 0.75) var max_distance_modifier : float = 0.25

func _physics_process(delta : float) -> void:
	if player == null:
		return
	
	var distance_to_player = player.global_transform.origin.distance_to(global_transform.origin)
	var direction = player.global_transform.origin - global_transform.origin
	direction.y = 0
	direction = direction.normalized()
	if distance_to_player > max_distance_to_player:
		move_and_slide(direction * move_speed, Vector3(0, 1, 0))
	else:
		if distance_to_player > min_hit_distance:
			move_and_slide(direction * move_speed, Vector3(0, 1, 0))
		if timer.is_stopped() and randf() < chance_to_shoot:
			move_and_slide(direction * move_speed, Vector3(0, 1, 0))
			raycast.cast_to = to_local(player.global_transform.origin)
			if raycast.is_colliding():
				timer.start()
				var is_player_in_sight = (raycast.get_collider() as Player) != null
				if is_player_in_sight:
					#Play shoot animation, check if misses
					if randf() > chance_to_miss:
						var distance = player.global_transform.origin.distance_to(global_transform.origin)
						var modifier = 1.25 - distance / max_hit_distance if distance < max_hit_distance else max_distance_modifier
						player.take_damage(damage * modifier)
