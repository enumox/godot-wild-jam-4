extends "res://actors/enemies/ranged-enemy/RangedEnemy.gd"

export var max_hit_distance : float
export var min_hit_distance : float
export(float, 0.1, 0.75) var max_distance_modifier : float = 0.25

var distance_to_player = 0

func _process(delta : float) -> void:
	distance_to_player = player.global_transform.origin.distance_to(global_transform.origin)
	direction = player.global_transform.origin - global_transform.origin
	direction.y = 0
	direction = direction.normalized()
	
	if animation.animation == 'idle' or animation.animation == 'attack' and animation.frame == 6:
		animation.play('walk')
	
	if timer.is_stopped() and randf() < chance_to_shoot:
		raycast.cast_to = to_local(player.global_transform.origin)
		if raycast.is_colliding():
			timer.start()
			var is_player_in_sight = (raycast.get_collider() as Player) != null
			if is_player_in_sight:
				animation.play('attack')
				if randf() > chance_to_miss:
					shoot()

func _physics_process(delta : float) -> void:
	if distance_to_player > max_distance_to_player or distance_to_player > min_hit_distance:
		if can_move(direction):
			move_and_slide(direction * move_speed, Vector3(0, 1, 0))
#	else:
#		if timer.is_stopped() and randf() < chance_to_shoot:
#			move_and_slide(direction * move_speed, Vector3(0, 1, 0))
#			raycast.cast_to = to_local(player.global_transform.origin)
#			if raycast.is_colliding():
#				timer.start()
#				var is_player_in_sight = (raycast.get_collider() as Player) != null
#				if is_player_in_sight:
#					#Play shoot animation, check if misses
#					if randf() > chance_to_miss:
#						shoot()

func shoot() -> void:
	var distance = player.global_transform.origin.distance_to(global_transform.origin)
	var modifier = 1.25 - distance / max_hit_distance if distance < max_hit_distance else max_distance_modifier
	player.take_damage(damage * modifier)