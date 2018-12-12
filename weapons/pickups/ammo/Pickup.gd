extends Area
class_name Pickup

onready var animation : = $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	connect('body_entered', self, '_on_body_entered')
