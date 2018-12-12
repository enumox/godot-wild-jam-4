extends "res://weapons/pickups/ammo/Pickup.gd"

onready var heal_amount : = 20

func _on_body_entered(body) -> void:
	var player = body as Player
	var healed = player.heal(heal_amount)
	if healed:
		queue_free()
