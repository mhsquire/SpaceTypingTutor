extends Sprite2D

# This is the script for all enemies that exist right now.
# Enemies and managed by EnemyManager which calls various methods here.
# 

signal destroyed(_on_destroy_enemy)


var orange = Color(Color.ORANGE)
var gray = Color(Color.GRAY)
var blue = Color(Color.AQUA)
var red = Color(Color.RED)
var damage = 0
var word = []


@onready var prompt = $RichTextLabel
@onready var prompt_text = prompt.text
@onready var reinforcement_timer = $ReinforcementTimer
@onready var words = get_node("../../Wordlist")


func _ready():
	reinforcement_timer.timeout.connect(_on_reinforcement_timer_timeout)


func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"


func get_bbcode_end_color_tag() -> String:
	return "[/color]"


func _set_to_center(string: String):
	return "[center]" + string + "[/center]"


func _indicate_character_position(next_character_index: int):
	var orange_text = get_bbcode_color_tag(blue) + word.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var blue_text = get_bbcode_color_tag(orange) + word.substr(next_character_index, -1) + get_bbcode_end_color_tag()
	prompt.parse_bbcode(_set_to_center(orange_text + blue_text))


func make_target(make_visible: bool) -> void:
	if make_visible:
		prompt.set("theme_override_colors/default_color", orange)
		prompt.set("theme_override_font_sizes/normal_font_size", 128)
	else:
		prompt.set("theme_override_colors/default_color", gray)
		prompt.set("theme_override_font_sizes/normal_font_size", 96)
		damage = 0
		$ProgressBar.value = 100 - damage


func make_destroyed() -> void:
	set_visible(0)
	print("Destroyed!")


func make_created() -> void:
	word = words.choose_word()
	_set_prompt_text(_set_to_center(word))
	set_visible(1)
	damage = 0
	$ProgressBar.value = 100 - damage
	print("Created")
	print("Health = ", damage)


func get_prompt_text() -> String:
	return prompt_text


func _set_prompt_text(new_text: String) -> void:
	prompt.text = new_text
	print("new text = ", new_text)


func take_damage() -> void:
	print("Word length = ", word.length())
	damage = damage + 1
	$ProgressBar.value = (word.length() - damage) * 100 / word.length()
	print("Damaged = ", damage)
	_indicate_character_position(damage)
	if damage >= word.length():
		destroyed.emit()


func make_timer_start(time_to_wait: int) -> void:
	reinforcement_timer.start(time_to_wait)


func _on_reinforcement_timer_timeout() -> void:
	make_created()
