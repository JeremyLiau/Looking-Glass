extends Node2D

onready var anim = $AnimatedSprite
var activated = false
onready var collisionShape = $StaticBody2D/CollisionShape2D


func on_interact():
	if(!activated):
		activated = true
		anim.play("activated")
	else:
		activated = false
		collisionShape.disabled = false
		anim.play("deactivated")


func _on_AnimatedSprite_animation_finished():
	pass
	if(activated):
		collisionShape.disabled = true
	#else:
	#	collisionShape.disabled = false
