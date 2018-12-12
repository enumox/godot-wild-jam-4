extends "res://weapons/Weapon.gd"

export var max_hit_distance : float
export(float, 0.1, 0.75) var max_distance_modifier : float = 0.25

func shoot() -> void:
	animation.play('shoot')
	ammo -= 1
	emit_signal('ammo_changed', ammo)
	if raycast.is_colliding():
		var enemy = raycast.get_collider() as Enemy
		if enemy != null:
			var distance = enemy.global_transform.origin.distance_to(global_transform.origin)
			var modifier = 1.25 - distance / max_hit_distance if distance < max_hit_distance else max_distance_modifier
			enemy.take_damage(damage * modifier)