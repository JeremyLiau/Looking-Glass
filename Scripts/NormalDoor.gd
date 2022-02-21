extends StaticBody2D

onready var anim = $AnimatedSprite
onready var collisionShape = $CollisionShape2D

func on_interact ():
	anim.frame = 1
	collisionShape.disabled = true
