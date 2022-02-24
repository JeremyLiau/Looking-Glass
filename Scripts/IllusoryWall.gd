extends Node2D

onready var collisionShape = $StaticBody2D/CollisionShape2D
var illusory = true
onready var tween = get_node("Tween")

var lookingGlassed = false #Terrible name, but essentially means that the looking glass is hovering over the object. This is checked to make sure that the lookingGlass fade effect takes precedence over the half-fade when the player stands behind an object
var playerBehind = false #One last check to fix visual clarity. Ensure that the fade remains at half-fade if the looking glass is removed while the player stands behind the object.


func _on_FadeArea_area_entered(area):
	if area.get_name() == "LookingGlass":
		if(illusory):
				lookingGlassed = true
				tweenEffect(1, 0)
		else:
				lookingGlassed = true
				if(playerBehind):
					tweenEffect(0, 0.5)
				else:
					tweenEffect(0, 1)

func _on_FadeArea_area_exited(area):
	if area.get_name() == "LookingGlass":
		if(illusory):
			lookingGlassed = false
			if(playerBehind):
				tweenEffect(0, 0.5)
			else:
				tweenEffect(0, 1)
		else:
			lookingGlassed = false
			if(playerBehind):
				tweenEffect(0.5, 0)
			else:
				tweenEffect(1, 0)

func _on_FadeArea_body_entered(body):
	playerBehind = true
	if body.get_name() == "Player":
		if(illusory and !lookingGlassed):
			tweenEffect(1, 0.5)
		elif(!illusory and lookingGlassed):
			tweenEffect(1, 0.5)

func _on_FadeArea_body_exited(body):
	playerBehind = false
	if(illusory and !lookingGlassed) or (!illusory and lookingGlassed):
		if body.get_name() == "Player":
			tweenEffect(0.5, 1)

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
