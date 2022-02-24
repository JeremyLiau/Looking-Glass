extends Node2D

onready var anim = $AnimatedSprite
var activated = false
onready var collisionShape = $StaticBody2D/CollisionShape2D
onready var tween = get_node("Tween")
var illusory = true
var lookingGlassed = false #Terrible name, but essentially means that the looking glass is hovering over the object. This is checked to make sure that the lookingGlass fade effect takes precedence over the half-fade when the player stands behind an object
var playerBehind = false #One last check to fix visual clarity. Ensure that the fade remains at half-fade if the looking glass is removed while the player stands behind the object.

func on_interact():
	if(!illusory):
		if(!activated):
			activated = true
			anim.play("activated")
		else:
			activated = false
			collisionShape.disabled = false
			anim.play("deactivated")

func _on_AnimatedSprite_animation_finished():
	if(activated):
		collisionShape.disabled = true

func _on_FadeArea_area_entered(area):
	if(illusory):
		if area.get_name() == "LookingGlass":
			lookingGlassed = true
			tween.interpolate_property(anim, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_area_exited(area):
	if(illusory):
		if area.get_name() == "LookingGlass":
			lookingGlassed = false
			if(playerBehind):
				tween.interpolate_property(anim, "modulate",
					Color(1,1,1,0), Color(1,1,1,0.5), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			else:
				tween.interpolate_property(anim, "modulate",
					Color(1,1,1,0), Color(1,1,1,1), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_body_entered(body):
	playerBehind = true
	if(illusory and !lookingGlassed):
		if body.get_name() == "Player":
			tween.interpolate_property(anim, "modulate",
			Color(1,1,1,1), Color(1,1,1,0.5), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_body_exited(body):
	playerBehind = false
	if(illusory and !lookingGlassed):
		if body.get_name() == "Player":
			tween.interpolate_property(anim, "modulate",
			Color(1,1,1,0.5), Color(1,1,1,1), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
