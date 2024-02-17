extends AnimatedSprite2D

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
	# Timers are used to "reinforce" enemies that have been destroyed
	reinforcement_timer.timeout.connect(_on_reinforcement_timer_timeout)
	shield_timer.timeout.connect(_on_shield_timer_timeout)


func get_bbcode_color_tag(color: Color) -> String:
	# Creates the "[color=#'color']" tag
	return "[color=#" + color.to_html(false) + "]"


func get_bbcode_end_color_tag() -> String:
	return "[/color]"


func _set_to_center(string: String):
	# centers text with BBCode
	return "[center]" + string + "[/center]"

func _heal_enemy() -> void:
	damage = 0
	_update_enemy_health()

func _update_enemy_health() -> void:
	# all the necessary calls to update health depending on damage.
	# Shield bar of Enemy
	$ShieldBar.value = (word.length() - damage) * 100 / word.length()
	_set_shield_level()
	reset_text_state()

func make_target(make_visible: bool) -> void:
	if make_visible:
		targeted = true
		_heal_enemy()
		prompt.set("theme_override_font_sizes/normal_font_size", 128)
	else:
		targeted = false
		_heal_enemy()
		prompt.set("theme_override_font_sizes/normal_font_size", 96)


func make_destroyed() -> void:
	set_visible(0)


func make_created() -> void:
	word = words.choose_word()
	play("Enemy")
	_heal_enemy()
	set_visible(1)



func get_prompt_text() -> String:
	return prompt_text


func _set_prompt_text(new_text: String) -> void:
	prompt.text = new_text


func _set_shield_level() -> void:
	# choose level of shield animation based on percentage damage.
	var percentage = 100 * (word.length() - damage) / word.length() 
	if percentage >= 100:
		$Shields.play("Full_Shield")
	elif percentage >= 70:
		$Shields.play("Half_Shield")
	elif percentage >= 30:
		$Shields.play("Low_Shield")
	else:
		$Shields.play("No_Shield") 


func take_damage() -> void:
	damage = damage + 1
	_update_enemy_health()
	if damage >= word.length():
		destroyed.emit()


func take_mistype() -> void:
	missed = true
	_heal_enemy()
	shield_timer.start(1)


func reset_text_state() -> void:
	# Color of text is dependant on the state of what is typed
	# Four strings are generated. Gray is for untargeted enemies.
	# Blue is for correctly typed letters. Orange is for letters 
	# that need typed. Red text is failed starting at the letter missed.
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
	_heal_enemy()
	missed = false
