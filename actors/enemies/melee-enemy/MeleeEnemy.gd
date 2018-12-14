extends "res://actors/enemies/Enemy.gd"

export var knock_back_force : float
export var attack_distance : float

var direction = Vector3()
var distance_to_player = 0

func _process(delta : float) -> void:
	distance_to_player = player.global_transform.origin.distance_to(global_transform.origin)
	direction = player.global_transform.origin - global_transform.origin
	direction.y = 0
	direction = direction.normalized()
	if animation.animation == 'idle' or animation.animation == 'attack' and animation.frame == 3:
		animation.play('walk')
	if distance_to_player < attack_distance and timer.is_stopped():
		timer.start()
		player.take_damage(damage,knock_back_force)
		animation.play('attack')

func _physics_process(delta : float) -> void:
	if distance_to_player > 5 and can_move(direction):
#		move_and_slide(direction * move_speed, Vector3(0, 1, 0))
		move_and_collide(direction * move_speed)
	