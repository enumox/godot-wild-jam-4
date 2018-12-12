extends CanvasLayer

onready var damage_overlay : = $DamageOverlay as Panel
onready var timer : = $Timer as Timer

onready var health_label : = $HUD/Health as Label
onready var ammo_label : = $HUD/Ammo as Label

func _on_Player_damaged():
	damage_overlay.show()
	timer.start()
	yield(timer, 'timeout')
	damage_overlay.hide()


func _on_Player_weapon_changed(weapon) -> void:
	pass # Replace with function body.

func _on_Player_health_changed(health) -> void:
	if health_label == null:
		yield(get_tree(), 'idle_frame')
	health_label.text = str(health)

func _on_Player_ammo_changed(ammo) -> void:
	if ammo_label == null:
		yield(get_tree(), 'idle_frame')
	ammo_label.text = str(ammo)
