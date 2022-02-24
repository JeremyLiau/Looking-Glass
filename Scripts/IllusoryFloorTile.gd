extends Node2D

onready var tween = get_node("Tween")
var illusory = true
onready var collisionShape = $StaticBody2D/CollisionShape2D

func _on_Area2D_area_entered(area):
	if area.get_name() == "LookingGlass":
		if(illusory):
			tweenEffect(1, 0)
		else:
			tweenEffect(0, 1)

func _on_Area2D_area_exited(area):
	if area.get_name() == "LookingGlass":
		if(illusory):
			tweenEffect(0, 1)
		else:
			tweenEffect(1, 0)

func illusion_toggle():
	if(illusory):
		illusory = false
		tweenEffect(1, 0)
		collisionShape.disabled = true
	else:
		illusory = true
		tweenEffect(0, 1)
		collisionShape.disabled = false

func tweenEffect(from, to):
	tween.interpolate_property($Sprite, "modulate",
	Color(1,1,1,from), Color(1,1,1,to), .2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
