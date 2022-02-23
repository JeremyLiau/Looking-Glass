extends Node2D

onready var anim = $AnimatedSprite
var activated = false
onready var collisionShape = $CollisionShape2D

func on_interact():
	if(!activated):
		activated = true
		anim.play("activated")
	else:
		activated = false
		anim.play("deactivated")


func _on_AnimatedSprite_animation_finished():
	if(activated):
		collisionShape.disabled = true
	else:
		collisionShape.disabled = false
