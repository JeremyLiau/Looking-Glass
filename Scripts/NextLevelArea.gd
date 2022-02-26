extends Node

func _on_Area2D_body_entered(body):
	get_tree().get_current_scene().transition()
