extends Node


var selected_enemy_index = 1


@onready var enemy1 = get_node("../Enemies/Enemy1")
@onready var enemy2 = get_node("../Enemies/Enemy2")
@onready var enemy3 = get_node("../Enemies/Enemy3")
@onready var enemies = [enemy1, enemy2, enemy3]


func _on_destroy_enemy() -> void:
	print("Enemy Destroyed")
	enemies[selected_enemy_index].make_destroyed()
	print("start timer")
	enemies[selected_enemy_index].make_timer_start(3.0)
	selected_enemy_index = (selected_enemy_index + 1) % enemies.size()
	update_selected_enemy_indicator()


func create_first_enemy_set():
	for i in range(enemies.size()):
		enemies[i].make_created()
	update_selected_enemy_indicator()


func update_selected_enemy_indicator():
	for i in range(enemies.size()):
		if i == selected_enemy_index:
			enemies[i].make_target(true)
		else:
			enemies[i].make_target(false)


func switch_enemy():
	# Calculate the new index by wrapping around
	selected_enemy_index = (selected_enemy_index + 1) % enemies.size()
	if not enemies[selected_enemy_index].is_visible():
		selected_enemy_index = (selected_enemy_index + 1) % enemies.size()
	update_selected_enemy_indicator()
		
	# Update the visual indication of the selected enemy (e.g., highlight)


func attack_enemy(letter: String) -> void:
	print(letter)
	var current_enemy = enemies[selected_enemy_index]
	print(current_enemy.word[current_enemy.damage].to_upper())
	if letter == current_enemy.word[current_enemy.damage].to_upper():
		enemies[selected_enemy_index].take_damage()
	else:
		enemies[selected_enemy_index].take_mistype()
