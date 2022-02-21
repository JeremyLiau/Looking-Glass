extends Node2D

onready var tween = get_node("Tween")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		print("Illusory floor switch stepped on")
		# Use disintegration effect to make the switch disappear when stepped on
		
func _on_Area2D_area_entered(area):
	if area.get_name() == "LookingGlass":
		tween.interpolate_property($Sprite, "modulate",
		Color(1,1,1,1), Color(1,1,1,0.5), .2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Area2D_area_exited(area):
	if area.get_name() == "LookingGlass":
		tween.interpolate_property($Sprite, "modulate",
		Color(1,1,1,0.5), Color(1,1,1,1), .2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
