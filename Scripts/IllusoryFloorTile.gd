extends Node2D

onready var tween = get_node("Tween")
export var illusory = false
onready var collisionShape = $StaticBody2D/CollisionShape2D
var lookingGlassed = false  #Terrible name, but essentially means that the looking glass is hovering over the object. This is used in the illusion toggle to retain visual when hovered with looking glass while toggling

func _ready():
	if(illusory):
		collisionShape.disabled = false
		$Sprite.modulate = Color(1,1,1,1)
	else:
		collisionShape.disabled = true
		$Sprite.modulate = Color(1,1,1,0)

func _on_Area2D_area_entered(area):
	if area.get_name() == "LookingGlass":
		lookingGlassed = true
		if(illusory):
			tweenEffect(1, 0)
		else:
			tweenEffect(0, 1)

func _on_Area2D_area_exited(area):
	if area.get_name() == "LookingGlass":
		lookingGlassed = false
		if(illusory):
			tweenEffect(0, 1)
		else:
			tweenEffect(1, 0)

func illusion_toggle():
	if(illusory):
		illusory = false
		if(!lookingGlassed):
			tweenEffect(1, 0)
		else:
			tweenEffect(0, 1)
		collisionShape.disabled = true
	else:
		illusory = true
		if(!lookingGlassed):
			tweenEffect(0, 1)
		else:
			tweenEffect(1, 0)
		collisionShape.disabled = false

func tweenEffect(from, to):
	tween.interpolate_property($Sprite, "modulate",
	Color(1,1,1,from), Color(1,1,1,to), .2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
