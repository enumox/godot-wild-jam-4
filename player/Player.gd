extends KinematicBody
class_name Player

signal damaged()

onready var camera : = $Camera as PlayerCamera
onready var weapon_manager : = $Camera/WeaponsManager as WeaponsManager

export var move_speed : float
export var gravity : float
export var acceleration : float
export var deceleration : float
export var health : int

var movement : = Vector3()
var direction : = Vector3()
var yaw : float = 0

func _ready() -> void:
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
	health = max(health - damage, 0)
	emit_signal('damaged')
	if health == 0:
		get_tree().reload_current_scene()







