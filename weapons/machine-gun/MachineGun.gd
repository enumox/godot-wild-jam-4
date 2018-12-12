extends "res://weapons/Weapon.gd"

func shoot() -> void:
	if not animation.is_playing():
		animation.play('rotate')
	ammo -= 1
	emit_signal('ammo_changed', ammo)
	if raycast.is_colliding():
		var enemy = raycast.get_collider() as Enemy
		if enemy != null:
			enemy.take_damage(damage)
