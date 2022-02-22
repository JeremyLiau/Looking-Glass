extends KinematicBody2D

var speed = 125

var velocity = Vector2.ZERO

var facingDir : Vector2 = Vector2()

var interactDist : int = 15

onready var anim = $AnimatedSprite

onready var raycast = $RayCast2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
	else:
		velocity = Vector2.ZERO
		
	move_and_collide(velocity * delta)
	
	if(velocity.y > 0): #Facing Down
		anim.frame = 0
		facingDir = Vector2(0, 1)
	elif(velocity.y < 0): #Facing Up
		anim.frame = 1
		facingDir = Vector2(0, -1)
	elif(velocity.x > 0): #Facing Right
		anim.frame = 3
		facingDir = Vector2(1, 0)
	elif(velocity.x < 0): #Facing Left
		anim.frame = 2
		facingDir = Vector2(-1, 0)
		
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		try_interact()
		
func try_interact():
	raycast.cast_to = facingDir * interactDist
	if raycast.is_colliding():
		if raycast.get_collider().has_method("on_interact"):
			raycast.get_collider().on_interact()
