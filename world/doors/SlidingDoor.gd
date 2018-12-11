extends Area

export(float, 0.1, 1.0) var open_time : float

onready var tween : = $Tween as Tween
onready var left_door : = $Left as MeshInstance
onready var right_door : = $Right as MeshInstance

var open : bool

func _ready() -> void:
	connect('body_entered', self, '_on_body_entered')

func _on_body_entered(body) -> void:
	if open:
		return
	var player = body as Player
	if player == null:
		return
	
	tween.interpolate_property(left_door, 'translation', left_door.translation, left_door.translation + Vector3(-3.1, 0 ,0), 1.0, Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.interpolate_property(right_door, 'translation', right_door.translation, right_door.translation + Vector3(3.1, 0 ,0), 1.0, Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()
	open = true
	