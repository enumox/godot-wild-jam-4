extends Spatial
class_name Weapon

signal ammo_changed(ammo)

export(int, 1, 10) var fire_rate : int = 1
export var ammo : int = 15
export var damage : float = 5.0
export(int, 0, 3) var selection_index : = 0
export var ammo_pickup_increase : = 5
export var icon : Texture

onready var timer : = $Timer as Timer
onready var muzzle_timer : = $MuzzleTimer as Timer
onready var animation : = $AnimationPlayer as AnimationPlayer
onready var audio_player : = $AudioStreamPlayer as AudioStreamPlayer
onready var muzzle_flash : = $MeshInstance/MuzzleFlash as SpotLight

var raycast : RayCast

func initialize(raycast : RayCast) -> void:
	self.raycast = raycast

func _ready() -> void:
	timer.wait_time = 1.0 / fire_rate
	connect('tree_entered', self, '_on_tree_entered')
	emit_signal('ammo_changed', ammo)
	animation.play('pickup')

func _on_tree_entered() -> void:
	animation.play('pickup')
	emit_signal('ammo_changed', ammo)

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
	emit_signal('ammo_changed', ammo)
	show_muzzle_flash()
	audio_player.play()
	if raycast.is_colliding():
		var enemy = raycast.get_collider() as Enemy
		if enemy != null:
			enemy.take_damage(damage)
	
func show_muzzle_flash() -> void:
	muzzle_flash.show()
	muzzle_timer.start()
	yield(muzzle_timer, 'timeout')
	muzzle_flash.hide()

func add_ammo() -> void:
	ammo += ammo_pickup_increase
	emit_signal('ammo_changed', ammo)

