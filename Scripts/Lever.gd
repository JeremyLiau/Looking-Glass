extends StaticBody2D

onready var anim = $AnimatedSprite
var illusionToggleMembers
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func lever_toggle():
	if(anim.animation == "deactivate" or anim.animation == "default"):
		anim.play("activate")
		illusionToggleMembers = get_tree().get_nodes_in_group("Toggle")
		for member in illusionToggleMembers:
			member.illusion_toggle()
	else:
		anim.play("deactivate")
		illusionToggleMembers = get_tree().get_nodes_in_group("Toggle")
		for member in illusionToggleMembers:
			member.illusion_toggle()
