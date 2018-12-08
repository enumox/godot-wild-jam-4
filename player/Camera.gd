extends Camera
class_name PlayerCamera

export(float, 0.1, 1.0) var mouse_sensibility : float
export(float, 75.0, 90.0) var max_rotation : float
var pitch : float
var direction : = Vector3()

func _input(event) -> void:
	if event is InputEventMouseMotion:
		pitch = max(min(pitch - event.relative.y * 0.5, max_rotation), -max_rotation)
		rotation = Vector3(deg2rad(pitch), rotation.y, 0)
