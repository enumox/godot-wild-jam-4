extends CanvasLayer

onready var damage_overlay : = $DamageOverlay as Panel
onready var heal_overlay : = $HealOverlay as Panel
onready var ammo_overlay : = $AmmoOverlay as Panel
onready var timer : = $Timer as Timer

onready var health_label : = $HUD/Health as Label
onready var ammo_label : = $HUD/Ammo as Label
onready var weapon_icon : = $HUD/WeaponIcon as TextureRect

func _on_Player_damaged():
	damage_overlay.show()
	timer.start()
	yield(timer, 'timeout')
	damage_overlay.hide()

func _on_Player_weapon_changed(weapon) -> void:
	if weapon_icon == null:
		yield(get_tree(), 'idle_frame')
	weapon_icon.texture = weapon.icon

func _on_Player_health_changed(health) -> void:
	if health_label == null:
		yield(get_tree(), 'idle_frame')
	health_label.text = str(health)

func _on_Player_ammo_changed(ammo) -> void:
	if ammo_label == null:
		yield(get_tree(), 'idle_frame')
	ammo_label.text = str(ammo)

func _on_Player_healed():
	heal_overlay.show()
	timer.start()
	yield(timer, 'timeout')
	heal_overlay.hide()
