extends Node

const TUTORIAL = preload("res://Scenes/Levels/Level0.tscn")
const LEVEL1 = preload("res://Scenes/Levels/Level1.tscn")
const LEVEL2 = preload("res://Scenes/Levels/Level2.tscn")
const LEVEL3 = preload("res://Scenes/Levels/Level3.tscn")
const LEVEL4 = preload("res://Scenes/Levels/Level4.tscn")
const LEVEL5 = preload("res://Scenes/Levels/Level5.tscn")
const EXITSPLASH = preload("res://Scenes/Levels/ExitSplash.tscn")

var levelOrder = [LEVEL1, LEVEL2, LEVEL3, LEVEL4, LEVEL5, EXITSPLASH]

func _on_TransitionScreen_transitioned():
	$CurrentScene.get_child(0).queue_free()
	if(!levelOrder.empty()):
		$CurrentScene.add_child(levelOrder[0].instance())
		levelOrder.pop_front()
	else:
		pass
		
func transition():
	$TransitionScreen.transition()


func _on_Music_finished():
	$Music.play()
