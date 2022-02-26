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
		
	if(velocity != Vector2(0, 0)):
		anim.playing = true
	else:
		anim.playing = false
	
	move_and_collide(velocity * delta)
	
	if(velocity.y > 0): #Facing Down
		anim.play("frontwalk")
		facingDir = Vector2(0, 1)
	elif(velocity.y < 0): #Facing Up
		anim.play("backwalk")
		facingDir = Vector2(0, -1)
	elif(velocity.x > 0): #Facing Right
		anim.play("sidewalk")
		anim.flip_h = true
		facingDir = Vector2(1, 0)
	elif(velocity.x < 0): #Facing Left
		anim.play("sidewalk")
		anim.flip_h = false
		facingDir = Vector2(-1, 0)
		
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		try_interact()
		
func try_interact():
	raycast.cast_to = facingDir * interactDist
	if raycast.is_colliding():
		if raycast.get_collider().has_method("lever_toggle"):
			raycast.get_collider().lever_toggle()
