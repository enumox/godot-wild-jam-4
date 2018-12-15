extends KinematicBody
class_name Player

signal damaged()
signal health_changed(health)
signal healed()
signal ammo_changed(ammo)
signal weapon_changed(weapon)
signal gems_changed(amount)

onready var camera : = $Camera as PlayerCamera
onready var weapon_manager : = $Camera/WeaponsManager as WeaponsManager
onready var audio_player : = $AudioStreamPlayer as AudioStreamPlayer

export var move_speed : float
export var gravity : float
export var acceleration : float
export var deceleration : float
export var max_health : int
export var hit_sound : AudioStreamSample

var health : int
var gems : int = 0 setget set_gems
var movement : = Vector3()
var direction : = Vector3()
var yaw : float = 0
var dead : bool = false

func _ready() -> void:
	health = max_health
	emit_signal('health_changed', health)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta : float) -> void:
	var motion = Vector3()
	motion.x = int(Input.is_action_pressed('move_right')) - int(Input.is_action_pressed('move_left'))
	motion.z = int(Input.is_action_pressed('move_forward')) - int(Input.is_action_pressed('move_backward'))
	motion.y = 0
	motion = motion.normalized()
	
	var frame_movement = movement.linear_interpolate(get_direction(motion) * move_speed, acceleration * delta)
	movement.x = frame_movement.x
	movement.z = frame_movement.z
	movement.y -= delta * gravity
	movement = move_and_slide(movement, Vector3(0, 1, 0))

func _input(event) -> void:
	if event is InputEventMouseMotion:
		yaw = fmod(yaw - event.relative.x * 0.5, 360)
		rotation = Vector3(rotation.x, deg2rad(yaw), 0)

func get_direction(motion : Vector3) -> Vector3:
	var direction : = Vector3()
	direction += Vector3(0,0,-1).rotated(Vector3(0,1,0), rotation.y).normalized() * motion.z
	direction += Vector3(1,0,0).rotated(Vector3(0,1,0), rotation.y).normalized() * motion.x
	direction.y = 0
	return direction.normalized()

func take_damage(damage : float, knock_back_force : float = 0) -> void:
	camera.shake()
	health = max(health - damage, 0)
	emit_signal('damaged')
	emit_signal('health_changed', health)
	play_sound(hit_sound)
	if health == 0 and not dead:
		dead = true
		set_process(false)
		set_physics_process(false)
		set_process_input(false)
		$Camera/WeaponsManager/Hand.queue_free()
		$Camera.translation = Vector3()
		$Camera.set_process(false)
		yield(get_tree().create_timer(2.0), 'timeout')
		get_tree().change_scene("res://interface/LoseMenu.tscn")

func play_sound(stream : AudioStreamSample) -> void:
	audio_player.stream = stream
	audio_player.play()

func heal(amount : int) -> bool:
	if health == max_health:
		return false
	health = min(health + amount, max_health)
	emit_signal('health_changed', health)
	emit_signal('healed')
	return true

func set_gems(new_value : int) -> void:
	gems = new_value
	emit_signal('gems_changed', gems)

func _on_WeaponsManager_weapon_changed(weapon) -> void:
	emit_signal('weapon_changed', weapon)
	weapon.connect('ammo_changed', self, '_on_weapon_ammo_changed')
	emit_signal('ammo_changed', weapon.ammo)

func _on_weapon_ammo_changed(ammo) -> void:
	camera.shake()
	emit_signal('ammo_changed', ammo)
