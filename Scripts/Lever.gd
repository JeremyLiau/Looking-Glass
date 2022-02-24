extends StaticBody2D

onready var anim = $AnimatedSprite
var illusionToggleMembers
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_interact ():
	if(anim.frame == 0):
		anim.frame = 1
		illusionToggleMembers = get_tree().get_nodes_in_group("Toggle")
		for member in illusionToggleMembers:
			member.illusion_toggle()
	else:
		anim.frame = 0
		illusionToggleMembers = get_tree().get_nodes_in_group("Toggle")
		for member in illusionToggleMembers:
			member.illusion_toggle()
