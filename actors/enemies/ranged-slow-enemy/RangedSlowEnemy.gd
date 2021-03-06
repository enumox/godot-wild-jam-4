extends "res://actors/enemies/ranged-enemy/RangedEnemy.gd"
export var projectile : PackedScene

func _process(delta : float) -> void:
	direction = Vector3()
	
	if animation.animation == 'idle' or animation.animation == 'attack' and animation.frame == 8:
		animation.play('walk')
	
	if player.global_transform.origin.distance_to(global_transform.origin) > max_distance_to_player:
		direction = player.global_transform.origin - global_transform.origin
		direction.y = 0
		direction = direction.normalized()

func _physics_process(delta : float) -> void:
	if can_move(direction):
		pass
#		move_and_slide(direction * move_speed, Vector3(0, 1, 0))
	if timer.is_stopped() and randf() < chance_to_shoot:
		raycast.cast_to = to_local(player.global_transform.origin)
		if raycast.is_colliding():
			timer.start()
			var is_player_in_sight = (raycast.get_collider() as Player) != null
			if is_player_in_sight:
				if randf() > chance_to_miss:
					var new_projectile = projectile.instance()
					new_projectile.initialize((player.global_transform.origin - global_transform.origin).normalized())
					add_child(new_projectile)
					animation.play('attack')

func shoot() -> void:
	pass