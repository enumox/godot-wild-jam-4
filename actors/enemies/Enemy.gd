extends KinematicBody
class_name Enemy

export var health : int
export var move_speed : float
export var damage : int
export(float, 0.5, 2) var attack_delay : float

onready var animation : = $AnimatedSprite3D as AnimatedSprite3D
onready var timer : = $Timer as Timer
onready var detection_area : = $DetectionArea as Area

var player

func _ready() -> void:
	timer.wait_time = attack_delay
	set_process(false)
	set_physics_process(false)

func take_damage(value : int) -> void:
	health = max(health - value, 0)
	if health == 0:
		animation.play('dead')
		$CollisionShape.queue_free()
		detection_area.queue_free()
		set_process(false)
		set_physics_process(false)

func _on_DetectionArea_body_entered(body):
	if body.name != "Player":
		return
	print('found player')
	player = body
	set_process(true)
	set_physics_process(true)
