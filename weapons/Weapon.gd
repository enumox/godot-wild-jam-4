extends Spatial
class_name Weapon

export(int, 1, 10) var fire_rate : int = 1
export var ammo : int = 15
export var damage : float = 5.0
export(int, 0, 3) var selection_index : = 0

onready var timer : = $Timer as Timer
onready var animation : = $AnimationPlayer as AnimationPlayer

var raycast : RayCast

func initialize(raycast : RayCast) -> void:
	self.raycast = raycast

func _ready() -> void:
	timer.wait_time = 1.0 / fire_rate
	connect('tree_entered', self, '_on_tree_entered')
	connect('tree_exiting', self, '_on_tree_exiting')
	animation.play('pickup')

func _on_tree_entered() -> void:
	animation.play('pickup')

func drop() -> void:
	animation.play('drop')
	yield(animation, 'animation_finished')
	
func _process(delta : float) -> void:
	if Input.is_action_pressed('shoot') and timer.is_stopped() and ammo > 0:
		timer.start()
		shoot()

func shoot() -> void:
	animation.play('shoot')
	ammo -= 1
	if raycast.is_colliding():
		print('colliding')