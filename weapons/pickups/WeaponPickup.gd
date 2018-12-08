extends Area
class_name WeaponPickup

export var weapon : PackedScene

func _ready() -> void:
	connect('body_entered', self, '_on_body_entered')

func _on_body_entered(body : PhysicsBody) -> void:
	var player = body as Player
	if player == null:
		return
	player.weapon_manager.add_weapon(weapon)
	queue_free()