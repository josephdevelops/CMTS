extends Control

var scenario_manager: ScenarioManager
var feedback_system: FeedbackSystem

var root_box: VBoxContainer
var title_label: Label
var content_label: RichTextLabel
var buttons_box: VBoxContainer
var footer_label: Label

func _ready() -> void:
	scenario_manager = ScenarioManager.new()
	add_child(scenario_manager)
	feedback_system = FeedbackSystem.new()
	add_child(feedback_system)

	_build_layout()
	_show_main_menu()

func _build_layout() -> void:
	root_box = VBoxContainer.new()
	root_box.anchor_left = 0.08
	root_box.anchor_top = 0.14
	root_box.anchor_right = 0.92
	root_box.anchor_bottom = 0.93
	root_box.add_theme_constant_override("separation", 18)
	add_child(root_box)

	title_label = Label.new()
	title_label.text = "Classroom Management Training Simulator"
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 34)
	root_box.add_child(title_label)

	content_label = RichTextLabel.new()
	content_label.fit_content = true
	content_label.bbcode_enabled = true
	content_label.custom_minimum_size = Vector2(900, 260)
	content_label.add_theme_font_size_override("normal_font_size", 22)
	root_box.add_child(content_label)

	buttons_box = VBoxContainer.new()
	buttons_box.add_theme_constant_override("separation", 10)
	root_box.add_child(buttons_box)

	footer_label = Label.new()
	footer_label.text = "CMTS prototype: UI → Simulation Engine → Scenario Data → Results/Feedback"
	footer_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	footer_label.add_theme_font_size_override("font_size", 16)
	root_box.add_child(footer_label)

func _clear_buttons() -> void:
	for child in buttons_box.get_children():
		child.queue_free()

func _add_button(text: String, callback: Callable) -> void:
	var button := Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(900, 48)
	button.add_theme_font_size_override("font_size", 18)
	button.pressed.connect(callback)
	buttons_box.add_child(button)

func _show_main_menu() -> void:
	$backgroundimg.visible = true
	_clear_buttons()
	title_label.text = " "
	content_label.text = " "
	_add_button("Start Scenario Training", Callable(self, "_show_scenario_select"))
	_add_button("Exit Prototype", Callable(self, "_quit_game"))

func _show_scenario_select() -> void:
	$backgroundimg.visible = false
	_clear_buttons()
	title_label.text = "Select a Scenario"
	content_label.text = "Choose one classroom situation to practice."

	var scenarios := scenario_manager.get_scenarios()
	for i in range(scenarios.size()):
		var scenario: Dictionary = scenarios[i]
		_add_button(str(i + 1) + ". " + str(scenario.get("title", "Scenario")), Callable(self, "_start_scenario").bind(i))

	_add_button("Back to Main Menu", Callable(self, "_show_main_menu"))

func _start_scenario(index: int) -> void:
	scenario_manager.set_current_scenario(index)
	_show_current_scenario()

func _show_current_scenario() -> void:
	_clear_buttons()
	var scenario := scenario_manager.get_current_scenario()
	title_label.text = str(scenario.get("title", "Scenario"))
	content_label.text = "[b]Grade Band:[/b] %s\n\n[b]Context:[/b] %s\n\n[b]Student Behavior:[/b] %s\n\n[b]Learning Goal:[/b] %s" % [
		scenario.get("grade_band", ""),
		scenario.get("context", ""),
		scenario.get("behavior_prompt", ""),
		scenario.get("learning_goal", "")
	]

	var options := scenario_manager.get_response_options()
	for option in options:
		_add_button(str(option.get("text", "Response option")), Callable(self, "_select_response").bind(option))

	_add_button("Choose Different Scenario", Callable(self, "_show_scenario_select"))

func _select_response(option: Dictionary) -> void:
	_clear_buttons()
	var scenario := scenario_manager.get_current_scenario()
	var result := feedback_system.build_feedback(option, scenario)
	title_label.text = "Feedback: " + str(result.get("rating", "Result"))
	content_label.text = "[b]Scenario:[/b] %s\n\n[b]Score:[/b] %s / 3\n\n[b]Feedback:[/b] %s\n\n[b]Connection to Learning Goal:[/b] %s" % [
		result.get("scenario_title", ""),
		result.get("score", 0),
		result.get("feedback", ""),
		result.get("learning_goal", "")
	]

	_add_button("Try Another Scenario", Callable(self, "_show_scenario_select"))
	_add_button("Return to Main Menu", Callable(self, "_show_main_menu"))

func _quit_game() -> void:
	get_tree().quit()
