class_name FeedbackSystem
extends Node

func build_feedback(selected_option: Dictionary, scenario: Dictionary) -> Dictionary:
	var score: int = int(selected_option.get("score", 0))
	var rating := "Needs Reflection"

	if score >= 3:
		rating = "Effective Response"
	elif score == 2:
		rating = "Developing Response"
	elif score == 1:
		rating = "Partially Effective"

	return {
		"scenario_title": str(scenario.get("title", "Scenario")),
		"rating": rating,
		"score": score,
		"feedback": str(selected_option.get("feedback", "No feedback available.")),
		"learning_goal": str(scenario.get("learning_goal", ""))
	}
