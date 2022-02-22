extends StaticBody2D

onready var anim = $AnimatedSprite

func on_interact ():
	if(anim.frame == 0):
		anim.frame = 1
	else:
		anim.frame = 0
