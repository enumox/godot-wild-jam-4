extends Spatial
class_name Weapon

export(int, 1, 10) var fire_rate : int = 1
export var ammo : int = 15

onready var timer : = $Timer as Timer
onready var animation : = $AnimationPlayer as AnimationPlayer

var raycast : RayCast

func initialize(raycast : RayCast) -> void:
	self.raycast = raycast

func _ready() -> void:
	timer.wait_time = 1.0 / fire_rate

func _process(delta : float) -> void:
	if Input.is_action_pressed('shoot') and timer.is_stopped() and ammo > 0:
		timer.start()
		shoot()

func shoot() -> void:
	animation.play('shoot')
	ammo -= 1
	if raycast.is_colliding():
		print('colliding')