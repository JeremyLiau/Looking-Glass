extends Node2D

onready var anim = $AnimatedSprite
var activated = false
onready var collisionShape = $StaticBody2D/CollisionShape2D
onready var tween = get_node("Tween")
var illusory = true

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
			tween.interpolate_property(anim, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_area_exited(area):
	if(illusory):
		if area.get_name() == "LookingGlass":
			tween.interpolate_property(anim, "modulate",
			Color(1,1,1,0), Color(1,1,1,1), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_body_entered(body):
	if(illusory):
		if body.get_name() == "Player":
			tween.interpolate_property(anim, "modulate",
			Color(1,1,1,1), Color(1,1,1,0.5), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_FadeArea_body_exited(body):
	if(illusory):
		if body.get_name() == "Player":
			tween.interpolate_property(anim, "modulate",
			Color(1,1,1,0.5), Color(1,1,1,1), .2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
