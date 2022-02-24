extends Node2D

onready var anim = $AnimatedSprite

onready var raycast = $RayCast2D
var interactDist : int = 32
var facingDir = Vector2(0, 1)
var activated = false

var illusory = true
onready var tween = get_node("Tween")

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
	else:
		activated = false
		anim.play("deactivated")

func _on_AnimatedSprite_animation_finished():
	try_interact()

func _on_FadeArea_area_entered(area):
	if area.get_name() == "LookingGlass":
		if(illusory):
			tweenEffect(1, 0)
		else:
			tweenEffect(0, 1)

func _on_FadeArea_area_exited(area):
	if area.get_name() == "LookingGlass":
		if(illusory):
			tweenEffect(0, 1)
		else:
			tweenEffect(1, 0)

func illusion_toggle():
	if(illusory):
		illusory = false
		tweenEffect(1, 0)
	else:
		illusory = true
		tweenEffect(0, 1)

func tweenEffect(from, to):
	tween.interpolate_property(anim, "modulate",
	Color(1,1,1,from), Color(1,1,1,to), .2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
