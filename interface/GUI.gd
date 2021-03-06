extends CanvasLayer

onready var damage_overlay : = $DamageOverlay as Panel
onready var heal_overlay : = $HealOverlay as Panel
onready var ammo_overlay : = $AmmoOverlay as Panel
onready var timer : = $Timer as Timer
onready var message_timer : = $MessageTimer as Timer


onready var health_label : = $HUD/Health as Label
onready var ammo_label : = $HUD/Ammo as Label
onready var gems_label : = $HUD/Gems as Label
onready var messages_label : = $HUD/Messages as Label
onready var weapon_icon : = $HUD/WeaponIcon as TextureRect

func _ready() -> void:
	messages_label.text = 'GET 5 CHIPS TO THE PORTAL'
	messages_label.show()
	message_timer.start()
	yield(message_timer, 'timeout')
	messages_label.hide()

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
	health_label.text = str(int(health))
	if health == 0:
		damage_overlay.show()

func _on_Player_ammo_changed(ammo) -> void:
	if ammo_label == null:
		yield(get_tree(), 'idle_frame')
	ammo_label.text = str(ammo)

func _on_Player_healed():
	heal_overlay.show()
	timer.start()
	yield(timer, 'timeout')
	heal_overlay.hide()

func _on_Player_gems_changed(amount):
	if messages_label == null:
		yield(get_tree(), 'idle_frame')
	gems_label.text = str(amount)
	var remainig = 5 - amount
	if remainig == 0:
		messages_label.text = 'All chips collected!\nGet them to the portal'
	elif remainig > 1:
		messages_label.text = str(remainig) + ' chips left'
	else:
		messages_label.text = str(remainig) + ' chip left'
	messages_label.show()
	message_timer.start()
	yield(message_timer, 'timeout')
	messages_label.hide()
