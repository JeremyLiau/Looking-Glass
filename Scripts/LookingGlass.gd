extends Area2D

var standardScale = Vector2(1, 1)
var iconScale = Vector2(0.1, 0.1)

onready var anim = $AnimatedSprite
var shineTimer = Timer.new()

func _ready():
	shineTimer.set_wait_time(20)
	shineTimer.connect("timeout", self, "shineAnimation")
	add_child(shineTimer)
	shineTimer.start()

func _physics_process(_delta):
	position = get_global_mouse_position()
	"""
	if Input.is_action_just_pressed("left_mouse"):
		if scale == standardScale:
			scale = iconScale
			$CollisionShape2D.disabled = true
		else:
			scale = standardScale
			$CollisionShape2D.disabled = false
	"""

func shineAnimation():
	anim.play("shine")

func _on_AnimatedSprite_animation_finished():
	anim.play("default")
