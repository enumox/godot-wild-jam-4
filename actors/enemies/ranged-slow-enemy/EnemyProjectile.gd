extends Area
class_name EnemyProjectile

export var damage : int
export var move_speed : int

var direction

func _ready() -> void:
	set_as_toplevel(true)
	connect('body_entered', self, '_on_body_entered')

func initialize(direction : Vector3) -> void:
	self.direction = direction

func _process(delta : float) -> void:
	translation += direction * move_speed * delta

func _on_body_entered(body) -> void:
	if body.is_a_parent_of(self):
		return
	var player = body as Player
	if player != null:
		player.take_damage(damage)
	queue_free()