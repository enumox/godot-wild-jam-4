extends Spatial
class_name WeaponsManager

onready var aim : = $Aim as RayCast
onready var hand : = $Hand

func _ready() -> void:
	hand.get_child(0).initialize(aim)