extends Node2D

onready var anim = $AnimatedSprite

onready var raycast = $RayCast2D
var interactDist : int = 32
var facingDir = Vector2(1, 0)
var activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.set_speed_scale(5)

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
