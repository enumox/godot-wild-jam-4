extends CanvasLayer

onready var damage_overlay : = $DamageOverlay as Panel
onready var timer : = $Timer as Timer

func _on_Player_damaged():
	damage_overlay.show()
	timer.start()
	yield(timer, 'timeout')
	damage_overlay.hide()
