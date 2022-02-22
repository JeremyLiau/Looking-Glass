extends Node2D

var isReal = true

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player" && isReal:
		print("Switch pressed")
