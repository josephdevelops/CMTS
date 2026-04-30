class_name StudentBehavior
extends RefCounted

var prompt: String = ""
var context: String = ""
var learning_goal: String = ""

func _init(new_prompt: String = "", new_context: String = "", new_learning_goal: String = "") -> void:
	prompt = new_prompt
	context = new_context
	learning_goal = new_learning_goal
