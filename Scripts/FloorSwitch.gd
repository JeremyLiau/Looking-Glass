extends Node2D

var isReal = true
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

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player" && isReal:
		if(!activated):
			activated = true
			anim.play("activated")
		else:
			activated = false
			anim.play("deactivated")

func try_interact(raycast, dir):
	raycast.cast_to = dir * interactDist
	if raycast.is_colliding():
		print(raycast.get_collider())
		if raycast.get_collider().has_method("on_interact"):
			raycast.get_collider().on_interact()


func _on_AnimatedSprite_animation_finished():
	try_interact(raycastNorth, northDir)
	try_interact(raycastEast, eastDir)
	try_interact(raycastSouth, southDir)
	try_interact(raycastWest, westDir)
