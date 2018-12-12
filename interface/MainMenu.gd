extends Control

export var arrow_offet : Vector2 = Vector2(-15, 8)

onready var buttons_container : = $MarginContainer/Column/Buttons as VBoxContainer
onready var transition_overlay : = $TransitionOverlay as ColorRect
onready var selection_arrow : = $SelectionArrow as Control
onready var tween : = $Tween as Tween

var buttons = []
var selected_index : int

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	buttons = buttons_container.get_children()
	selection_arrow.rect_global_position = _get_arrow_position()

func _unhandled_input(event) -> void:
	if event.is_action_pressed('ui_up'):
		selected_index = max(selected_index - 1, 0)
		_move_arrow()
	elif event.is_action_pressed('ui_down'):
		selected_index = min(selected_index + 1, buttons.size() - 1)
		_move_arrow()
	elif event.is_action_pressed('ui_accept'):
		var path = buttons[selected_index].path
		yield(_transition(), "completed")
		if path == '':
			get_tree().quit()
		else:
			get_tree().change_scene(path)

func _move_arrow() -> void:
	var move_to = _get_arrow_position(selected_index)
	tween.interpolate_property(selection_arrow, 
		"rect_global_position", 
		selection_arrow.rect_global_position, 
		move_to, 
		0.1, 
		Tween.TRANS_QUART, 
		Tween.EASE_OUT
	)
	tween.start()

func _transition() -> void:
	tween.interpolate_property(transition_overlay, 
		"self_modulate", 
		transition_overlay.self_modulate, 
		Color('ff426894'), 
		0.5, 
		Tween.TRANS_QUART, 
		Tween.EASE_OUT
	)
	tween.start()
	yield(tween, 'tween_completed')

func _get_arrow_position(button_index : int = 0) -> Vector2:
	return Vector2(buttons[button_index].get_global_rect().position.x + arrow_offet.x, buttons[button_index].get_global_rect().position.y + arrow_offet.y)