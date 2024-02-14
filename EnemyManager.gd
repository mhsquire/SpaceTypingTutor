extends Node

@onready
var enemy1 = get_node("../Enemies/Enemy1")
@onready
var enemy2 = get_node("../Enemies/Enemy2")
@onready
var enemy3 = get_node("../Enemies/Enemy3")
@onready
var enemies = [enemy1, enemy2, enemy3]

var selected_enemy_index = 1



func create_first_enemy_set():
	update_selected_enemy_indicator()


func update_selected_enemy_indicator():
	for i in range(enemies.size()):
		if i == selected_enemy_index:
			enemies[i].make_target(true)
		else:
			enemies[i].make_target(false)


func switch_enemy():
	# Calculate the new index by wrapping around
	print(selected_enemy_index)
	selected_enemy_index = (selected_enemy_index + 1) % enemies.size()
	print(selected_enemy_index)
	# Update the visual indication of the selected enemy (e.g., highlight)
	update_selected_enemy_indicator()


func destroy_enemy() -> void:
	print("Enemy Destroyed")
	enemies[selected_enemy_index].make_destroyed()
	enemies[selected_enemy_index].make_timer_start(3.0)
	selected_enemy_index = (selected_enemy_index + 1) % enemies.size()
	update_selected_enemy_indicator()
	

