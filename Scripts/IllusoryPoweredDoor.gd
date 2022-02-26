extends Node2D

onready var anim = $AnimatedSprite
var activated = false
onready var collisionShape = $StaticBody2D/CollisionShape2D
onready var tween = get_node("Tween")
export var illusory = true # Ignored if isReal is true
var lookingGlassed = false #Terrible name, but essentially means that the looking glass is hovering over the object. This is checked to make sure that the lookingGlass fade effect takes precedence over the half-fade when the player stands behind an object
var playerBehind = false #One last check to fix visual clarity. Ensure that the fade remains at half-fade if the looking glass is removed while the player stands behind the object.
export var hasWall = false # Ignored if isReal is true
onready var wallSpr = $WallSprite
onready var wallCollision = $WallCollision/CollisionShape2D
export var isReal = false

func _ready():
	if isReal:
		hasWall = false
		illusory = false
		collisionShape.disabled = false
	if(hasWall):
		wallCollision.disabled = false
		wallSpr.visible = true
	else:
		wallCollision.disabled = true
		wallSpr.visible = false

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
	if(!isReal):
		if area.get_name() == "LookingGlass":
			if(illusory):
					lookingGlassed = true
					tweenEffect(1, 0)
			else:
					lookingGlassed = true
					if(playerBehind and !activated):
						tweenEffect(0, 0.5)
					else:
						tweenEffect(0, 1)
						tween.interpolate_property(wallSpr, "modulate",
						Color(1,1,1,1), Color(1,1,1,0), .2,
						Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
						tween.start()
			if(hasWall and illusory):
				if(playerBehind):
					tween.interpolate_property(wallSpr, "modulate",
					Color(1,1,1,0), Color(1,1,1,0.5), .2,
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
					tween.start()
				else:
					tween.interpolate_property(wallSpr, "modulate",
					Color(1,1,1,0), Color(1,1,1,1), .2,
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
					tween.start()

func _on_FadeArea_area_exited(area):
	if(!isReal):
		if area.get_name() == "LookingGlass":
			if(illusory):
				lookingGlassed = false
				if(playerBehind and !activated):
					tweenEffect(0, 0.5)
				else:
					tweenEffect(0, 1)
			else:
				lookingGlassed = false
				if(playerBehind):
					tweenEffect(0.5, 0)
				else:
					tweenEffect(1, 0)
					tween.interpolate_property(wallSpr, "modulate",
					Color(1,1,1,0), Color(1,1,1,1), .2,
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
					tween.start()
			if(hasWall and illusory):
				tween.interpolate_property(wallSpr, "modulate",
				Color(1,1,1,1), Color(1,1,1,0), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()

func _on_FadeArea_body_entered(body):
	playerBehind = true
	if body.get_name() == "Player":
		if(!activated):
			if(illusory and !lookingGlassed):
				tweenEffect(1, 0.5)
			elif(!illusory and lookingGlassed):
				tweenEffect(1, 0.5)
			elif(isReal):
				tweenEffect(1, 0.5)
			elif(illusory and lookingGlassed and hasWall):
				tweenEffect(1,0)
				tween.interpolate_property(wallSpr, "modulate",
				Color(1,1,1,1), Color(1,1,1,0.5), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()

func _on_FadeArea_body_exited(body):
	playerBehind = false
	if(illusory and lookingGlassed and hasWall):
		tween.interpolate_property(wallSpr, "modulate",
		Color(1,1,1,0.5), Color(1,1,1,1), .2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	elif(illusory and !lookingGlassed) or (!illusory and lookingGlassed) or (isReal): #Not certain if this is elif, but was if previously
		if body.get_name() == "Player":
			if(!activated):
				tweenEffect(0.5, 1)

func illusion_toggle():
	if(!isReal):
		if(illusory):
			illusory = false
			if(hasWall):
				wallCollision.disabled = true
			if(!lookingGlassed):
				tweenEffect(1, 0)
				tween.interpolate_property(wallSpr, "modulate",
				Color(1,1,1,0), Color(1,1,1,1), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
			else:
				tweenEffect(0, 1)
				tween.interpolate_property(wallSpr, "modulate",
				Color(1,1,1,1), Color(1,1,1,0), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
			if(!activated):
				collisionShape.disabled = false
		else:
			illusory = true
			if(hasWall):
				wallCollision.disabled = false
			if(!lookingGlassed):
				tweenEffect(0, 1)
				tween.interpolate_property(wallSpr, "modulate",
				Color(1,1,1,1), Color(1,1,1,0), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
			else:
				tweenEffect(1, 0)
				tween.interpolate_property(wallSpr, "modulate",
				Color(1,1,1,0), Color(1,1,1,1), .2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				tween.start()
			if(!activated):
				collisionShape.disabled = true

func tweenEffect(from, to):
	tween.interpolate_property(anim, "modulate",
	Color(1,1,1,from), Color(1,1,1,to), .2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func isIllusory():
	return illusory
	
func isActivated():
	return activated
