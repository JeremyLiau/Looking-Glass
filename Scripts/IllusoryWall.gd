extends Node2D

onready var collisionShape = $StaticBody2D/CollisionShape2D
var illusory = true
onready var tween = get_node("Tween")

var lookingGlassed = false #Terrible name, but essentially means that the looking glass is hovering over the object. This is checked to make sure that the lookingGlass fade effect takes precedence over the half-fade when the player stands behind an object
var playerBehind = false #One last check to fix visual clarity. Ensure that the fade remains at half-fade if the looking glass is removed while the player stands behind the object.


func _on_FadeArea_area_entered(area):
	if(illusory):
		if area.get_name() == "LookingGlass":
			lookingGlassed = true
			tween.interpolate_property($Sprite, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_area_exited(area):
	if(illusory):
		if area.get_name() == "LookingGlass":
			lookingGlassed = false
			if(playerBehind):
				tween.interpolate_property($Sprite, "modulate",
					Color(1,1,1,0), Color(1,1,1,0.5), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			else:
				tween.interpolate_property($Sprite, "modulate",
					Color(1,1,1,0), Color(1,1,1,1), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_body_entered(body):
	playerBehind = true
	if(illusory and !lookingGlassed):
		if body.get_name() == "Player":
			tween.interpolate_property($Sprite, "modulate",
			Color(1,1,1,1), Color(1,1,1,0.5), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_body_exited(body):
	playerBehind = false
	if(illusory and !lookingGlassed):
		if body.get_name() == "Player":
			tween.interpolate_property($Sprite, "modulate",
			Color(1,1,1,0.5), Color(1,1,1,1), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
