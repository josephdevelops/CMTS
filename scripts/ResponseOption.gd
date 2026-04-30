class_name ResponseOption
extends RefCounted

var id: String = ""
var text: String = ""
var score: int = 0
var feedback: String = ""

func _init(data: Dictionary = {}) -> void:
	id = str(data.get("id", ""))
	text = str(data.get("text", ""))
	score = int(data.get("score", 0))
	feedback = str(data.get("feedback", ""))
