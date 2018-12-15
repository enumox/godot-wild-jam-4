extends Camera
class_name PlayerCamera

export(float, 0.1, 1.0) var mouse_sensibility : float
export(float, 75.0, 90.0) var max_rotation : float

export(float) var amplitude = 6.0
export(float) var duration = 0.8 setget set_duration
export(float, EASE) var DAMP_EASING = 1.0
export(bool) var shake = false setget set_shake

onready var timer = $Timer

var pitch : float
var direction : = Vector3()

func _input(event) -> void:
	if event is InputEventMouseMotion:
		pitch = max(min(pitch - event.relative.y * 0.5, max_rotation), -max_rotation)
		rotation = Vector3(deg2rad(pitch), rotation.y, 0)

func _ready():
	self.duration = duration
	set_process(false)
	randomize()

func set_duration(value):
	duration = value
	if not timer:
		return
	timer.wait_time = duration

func set_shake(value):
	shake = value
	set_process(shake)

func shake() -> void:
	set_process(true)
	timer.start()
	yield(timer, "timeout")

func _process(delta):
	var damping = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	h_offset = rand_range(amplitude, -amplitude) * damping
	v_offset = rand_range(amplitude, -amplitude) * damping

func _on_timer_timeout():
	self.shake = false