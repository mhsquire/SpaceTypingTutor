extends Sprite2D


@onready var prompt = $TextToType
@onready var prompt_text = prompt.text
@onready var reinforcement_timer = $ReinforcementTimer
var orange = Color(Color.ORANGE)
var gray = Color(Color.GRAY)


func _ready():
	reinforcement_timer.timeout.connect(_on_reinforcement_timer_timeout)

func _on_reinforcement_timer_timeout() -> void:
	set_visible(1)


func make_target(make_visible: bool) -> void:
	if make_visible:
		prompt.set("theme_override_colors/default_color", orange)
		print(prompt.text)
	else:
		prompt.set("theme_override_colors/default_color", gray)


func make_destroyed() -> void:
	set_visible(0)
	print("Destroyed!")


func make_created() -> void:
	set_visible(1)
	print("Created")


func get_prompt_text() -> String:
	return prompt_text


func set_prompt_text(new_text: String) -> void:
	prompt.text = new_text
	print("new text = ", new_text)
	

func make_timer_start(time_to_wait: int) -> void:
	reinforcement_timer.start(time_to_wait)
