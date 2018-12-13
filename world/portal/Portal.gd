extends Area

func _ready() -> void:
	connect('body_entered', self, '_on_body_entered')

func _on_body_entered(body) -> void:
	var player = body as Player
	if player == null or player.gems < 5:
		print("LOST")
		return
	print('WON')