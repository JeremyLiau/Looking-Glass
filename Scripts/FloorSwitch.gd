extends Node2D
onready var anim = $AnimatedSprite
var activated = false

onready var raycastNorth = $RayCastNorth
var northDir = Vector2(0, -1)
onready var raycastEast = $RayCastEast
var eastDir = Vector2(1, 0)
onready var raycastSouth = $RayCastSouth
var southDir = Vector2(0, 1)
onready var raycastWest = $RayCastWest
var westDir = Vector2(-1, 0)

var interactDist : int = 32

export var isReal = true # No toggle between illusory and non-illusory
export var illusory = true #Toggle exists between illusory and non-illusory, if true, start as an illusory object
onready var tween = get_node("Tween")
var lookingGlassed = false #Terrible name, but essentially means that the looking glass is hovering over the object. This is used in the illusion toggle to retain visual when hovered with looking glass while toggling

func _ready():
	anim.set_speed_scale(1.5)

func _on_Area2D_body_entered(body):
	if(!illusory or isReal):
		if body.get_name() == "Player":
			if(!activated):
				activated = true
				anim.play("activated")
			else:
				activated = false
				anim.play("deactivated")

func try_interact(raycast, dir):
	raycast.cast_to = dir * interactDist
	if raycast.is_colliding():
		if raycast.get_collider().has_method("isIllusory"):
			if(!raycast.get_collider().isIllusory()):
				if(raycast.get_collider().has_method("isActivated")):
					if(raycast.get_collider().isActivated() and !activated) or (!raycast.get_collider().isActivated() and activated):
						if raycast.get_collider().has_method("on_interact"):
							raycast.get_collider().on_interact()

func _on_AnimatedSprite_animation_finished():
	try_interact(raycastNorth, northDir)
	try_interact(raycastEast, eastDir)
	try_interact(raycastSouth, southDir)
	try_interact(raycastWest, westDir)

func _on_FadeArea_area_entered(area):
	if(!isReal):
		if area.get_name() == "LookingGlass":
			lookingGlassed = true
			if(illusory):
				tweenEffect(1, 0)
			else:
				tweenEffect(0, 1)

func _on_FadeArea_area_exited(area):
	if(!isReal):
		if area.get_name() == "LookingGlass":
			lookingGlassed = false
			if(illusory):
				tweenEffect(0, 1)
			else:
				tweenEffect(1, 0)

func illusion_toggle():
	if(!isReal):
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
