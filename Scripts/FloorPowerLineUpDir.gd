extends Node2D

onready var anim = $AnimatedSprite

onready var raycast = $RayCast2D
var interactDist : int = 32
var facingDir = Vector2(0, -1)
var activated = false

func try_interact():
	raycast.cast_to = facingDir * interactDist
	if raycast.is_colliding():
		if raycast.get_collider().has_method("on_interact"):
			raycast.get_collider().on_interact()
			
func on_interact():
	if(!activated):
		activated = true
		anim.play("activated")
		#anim.play()
	else:
		activated = false
		anim.play("deactivated")

func _on_AnimatedSprite_animation_finished():
	try_interact()
