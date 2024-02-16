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
@onready var shield_timer = $ShieldTimer
@onready var words = get_node("../../Wordlist")
@onready var targeted = false
@onready var missed = false


func _ready():
	reinforcement_timer.timeout.connect(_on_reinforcement_timer_timeout)


func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"


func get_bbcode_end_color_tag() -> String:
	return "[/color]"


func _set_to_center(string: String):
	return "[center]" + string + "[/center]"


func make_target(make_visible: bool) -> void:
	if make_visible:
		targeted = true
		damage = 0
		$ProgressBar.value = 100
		reset_text_state()
		prompt.set("theme_override_font_sizes/normal_font_size", 128)
	else:
		targeted = false
		damage = 0
		$ProgressBar.value = 100
		reset_text_state()
		prompt.set("theme_override_font_sizes/normal_font_size", 96)


func make_destroyed() -> void:
	set_visible(0)


func make_created() -> void:
	word = words.choose_word()
	reset_text_state()
	set_visible(1)
	damage = 0
	$ProgressBar.value = 100


func get_prompt_text() -> String:
	return prompt_text


func _set_prompt_text(new_text: String) -> void:
	prompt.text = new_text


func take_damage() -> void:
	damage = damage + 1
	reset_text_state()
	if damage >= word.length():
		destroyed.emit()


func take_mistype() -> void:
	missed = true
	reset_text_state()
	shield_timer.start(1)


func reset_text_state() -> void:
	var gray_text = get_bbcode_color_tag(gray) + word + get_bbcode_end_color_tag()
	var blue_text = get_bbcode_color_tag(blue) + word.substr(0, damage) + get_bbcode_end_color_tag()
	var orange_text = get_bbcode_color_tag(orange) + word.substr(damage, -1) + get_bbcode_end_color_tag()
	var red_text = get_bbcode_color_tag(red) + word.substr(damage, -1) + get_bbcode_end_color_tag()
	if targeted:
		if missed:
			prompt.parse_bbcode(_set_to_center(blue_text + red_text))
		elif not missed:
			prompt.parse_bbcode(_set_to_center(blue_text + orange_text))
	elif not targeted:
		prompt.parse_bbcode(_set_to_center(gray_text))


func make_timer_start(time_to_wait: int) -> void:
	reinforcement_timer.start(time_to_wait)


func _on_reinforcement_timer_timeout() -> void:
	make_created()


func _on_shield_timer_timeout():
	if is_visible_in_tree() and targeted:
		damage = 0
		$ProgressBar.value = 100
		missed = false
		reset_text_state()
	else:
		missed = false
