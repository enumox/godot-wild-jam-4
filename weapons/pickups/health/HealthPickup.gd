extends "res://weapons/pickups/ammo/Pickup.gd"

onready var heal_amount : = 20

func _on_body_entered(body) -> void:
	var player = body as Player
	if player == null:
		return
	var healed = player.heal(heal_amount)
	if healed:
		$AudioStreamPlayer.play()
		yield($AudioStreamPlayer, 'finished')
		queue_free()
