extends Node2D

onready var anim = $AnimatedSprite

onready var raycast = $RayCast2D
var interactDist : int = 32
var facingDir = Vector2(0, -1)
var activated = false

var illusory = true
onready var tween = get_node("Tween")
var lookingGlassed = false #Terrible name, but essentially means that the looking glass is hovering over the object. This is checked to make sure that the lookingGlass fade effect takes precedence over the half-fade when the player stands behind an object

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
		lookingGlassed = true
		if(illusory):
			tweenEffect(1, 0)
		else:
			tweenEffect(0, 1)

func _on_FadeArea_area_exited(area):
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
	else:
		illusory = true
		if(!lookingGlassed):
			tweenEffect(0, 1)
		else:
			tweenEffect(1, 0)

func tweenEffect(from, to):
	tween.interpolate_property(anim, "modulate",
	Color(1,1,1,from), Color(1,1,1,to), .2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func isIllusory():
	return illusory

func isActivated():
	return activated
