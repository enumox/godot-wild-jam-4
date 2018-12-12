extends "res://actors/enemies/ranged-enemy/RangedEnemy.gd"
export var projectile : PackedScene

func _physics_process(delta : float) -> void:
	if player == null:
		return
	
	if player.global_transform.origin.distance_to(global_transform.origin) > max_distance_to_player:
		var direction = player.global_transform.origin - global_transform.origin
		direction.y = 0
		direction = direction.normalized()
		move_and_slide(direction * move_speed, Vector3(0, 1, 0))
	elif timer.is_stopped() and randf() < chance_to_shoot:
		raycast.cast_to = to_local(player.global_transform.origin)
		if raycast.is_colliding():
			timer.start()
			var is_player_in_sight = (raycast.get_collider() as Player) != null
			if is_player_in_sight:
				#Play shoot animation, check if misses
				if randf() > chance_to_miss:
					var new_projectile = projectile.instance()
					new_projectile.initialize((player.global_transform.origin - global_transform.origin).normalized())
					add_child(new_projectile)

func shoot() -> void:
	pass