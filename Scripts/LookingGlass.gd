extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var standardScale = Vector2(1, 1)
var iconScale = Vector2(0.1, 0.1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("left_mouse"):
		if scale == standardScale:
			scale = iconScale
		else:
			scale = standardScale
