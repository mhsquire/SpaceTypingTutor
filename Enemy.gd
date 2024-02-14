extends Sprite2D


@onready var prompt = $TextToType
@onready var prompt_text = prompt.text
@onready var reinforcement_timer = $ReinforcementTimer
var orange = Color(Color.ORANGE)
var gray = Color(Color.GRAY)

var damage = 0
var max_damage = 3
signal destroyed(_on_destroy_enemy)

func _ready():
	reinforcement_timer.timeout.connect(_on_reinforcement_timer_timeout)

func _on_reinforcement_timer_timeout() -> void:
	damage = max_damage
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
	damage = max_damage
	print("Created")


func get_prompt_text() -> String:
	return prompt_text


func set_prompt_text(new_text: String) -> void:
	prompt.text = new_text
	print("new text = ", new_text)


func take_damage() -> void:
	print("Damaged = ", damage)
	damage = damage - 1
	if damage <= 0:
		destroyed.emit()

func make_timer_start(time_to_wait: int) -> void:
	reinforcement_timer.start(time_to_wait)


