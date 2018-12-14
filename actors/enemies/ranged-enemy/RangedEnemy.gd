extends "res://actors/enemies/Enemy.gd"

export var max_distance_to_player : float
export(float, 0.1, 1.0) var chance_to_shoot : float
export(float, 0.1, 1.0) var chance_to_miss : float

onready var raycast : = $RayCast as RayCast

var direction = Vector3()

func _ready() -> void:
	._ready()
	randomize()

func _process(delta : float) -> void:
	if animation.animation == 'idle' or animation.animation == 'attack' and animation.frame == 8:
		animation.play('walk')
	
	if player.global_transform.origin.distance_to(global_transform.origin) > max_distance_to_player:
		direction = player.global_transform.origin - global_transform.origin
		direction.y = 0
		direction = direction.normalized()

func _physics_process(delta : float) -> void:
	if can_move(direction):
		move_and_slide(direction * 5, Vector3(0, 1, 0))
	if timer.is_stopped() and randf() < chance_to_shoot:
		raycast.cast_to = to_local(player.global_transform.origin)
		if raycast.is_colliding():
			timer.start()
			var is_player_in_sight = (raycast.get_collider() as Player) != null
			if is_player_in_sight:
				#Play shoot animation, check if misses
				animation.play('attack')
				if randf() > chance_to_miss:
					shoot()

func shoot() -> void:
	player.take_damage(damage)