extends Spatial
class_name WeaponsManager

onready var aim : = $Aim as RayCast
onready var hand : = $Hand

var selected_index : int = 0
var weapons = [
	null,
	null,
	null,
	null
]

func _ready() -> void:
	var initial_weapon = hand.get_child(0) as Weapon
	initial_weapon.initialize(aim)
	selected_index = initial_weapon.selection_index
	weapons[selected_index] = initial_weapon

func _process(delta : float) -> void:
	if Input.is_action_just_pressed('ui_accept'):
		add_weapon(load("res://weapons/Shotgun.tscn"))
	
	if Input.is_action_pressed('select_pistol'):
		switch_weapon(0)
	elif Input.is_action_pressed('select_shotgun'):
		switch_weapon(1)
	elif Input.is_action_pressed('select_machine_gun'):
		switch_weapon(2)
	elif Input.is_action_pressed('select_grenade_launcher'):
		switch_weapon(3)

func add_weapon(weapon) -> void:
	var new_weapon = weapon.instance()
	new_weapon.initialize(aim)
	if weapons[new_weapon.selection_index] != null:
		weapons[new_weapon.selection_index].ammo += new_weapon.ammo
		return
	else:
		weapons[new_weapon.selection_index] = new_weapon
	yield(hand.get_child(0).drop(), 'completed')
	hand.remove_child(hand.get_child(0))
	hand.add_child(new_weapon)

func switch_weapon(index : int) -> void:
	if weapons[index] == null or index == selected_index:
		return
	selected_index = index
	yield(hand.get_child(0).drop(), 'completed')
	hand.remove_child(hand.get_child(0))
	hand.add_child(weapons[index])
	