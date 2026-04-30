class_name ScenarioManager
extends Node

const SCENARIO_PATH := "res://data/scenarios.json"

var scenarios: Array = []
var current_index: int = 0

func _ready() -> void:
	load_scenarios()

func load_scenarios() -> void:
	if not FileAccess.file_exists(SCENARIO_PATH):
		push_error("Scenario file not found: " + SCENARIO_PATH)
		return

	var file := FileAccess.open(SCENARIO_PATH, FileAccess.READ)
	var json_text := file.get_as_text()
	var parsed = JSON.parse_string(json_text)

	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Scenario JSON could not be parsed.")
		return

	scenarios = parsed.get("scenarios", [])
	current_index = 0

func get_scenarios() -> Array:
	return scenarios

func get_current_scenario() -> Dictionary:
	if scenarios.is_empty():
		return {}
	return scenarios[current_index]

func set_current_scenario(index: int) -> void:
	if index >= 0 and index < scenarios.size():
		current_index = index

func get_response_options() -> Array:
	return get_current_scenario().get("response_options", [])
