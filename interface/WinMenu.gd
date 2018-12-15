extends "res://interface/MainMenu.gd"

onready var comment : = $Comment as AudioStreamPlayer

onready var audios = [
	preload("res://sounds/bad-motherfucker-masterized.wav"),
	preload("res://sounds/awesome.wav"),
	preload("res://sounds/good-job.wav"),
	preload("res://sounds/no-this-cannot-be.wav")
]

func _ready() -> void:
	randomize()
	comment.stream = audios[randi() % audios.size()]
	comment.play()