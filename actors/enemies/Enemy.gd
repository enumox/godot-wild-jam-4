extends KinematicBody
class_name Enemy

export var health : int
export var move_speed : float

onready var animation : = $AnimatedSprite3D as AnimatedSprite3D

func take_damage(value : int) -> void:
	health = max(health - value, 0)
	if health == 0:
		animation.play('dead')
		$CollisionShape.queue_free()
		set_process(false)
		set_physics_process(false)
