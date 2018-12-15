extends "res://interface/MainMenu.gd"

onready var comment : = $Comment as AudioStreamPlayer

onready var audios = [
	preload("res://sounds/you-lose.wav"),
	preload("res://sounds/deep-laugh.wav"),
	preload("res://sounds/bad-motherfucker-masterized.wav"),
	preload("res://sounds/pathetic.wav"),
]

func _ready() -> void:
	randomize()
	comment.stream = audios[randi() % audios.size()]
	comment.play()