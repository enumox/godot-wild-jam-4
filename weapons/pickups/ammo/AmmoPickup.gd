extends "res://weapons/pickups/ammo/Pickup.gd"
class_name AmmoPickup

func _on_body_entered(body) -> void:
	var player = body as Player
	if player == null:
		return
	player.weapon_manager.add_ammo()
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, 'finished')
	queue_free()