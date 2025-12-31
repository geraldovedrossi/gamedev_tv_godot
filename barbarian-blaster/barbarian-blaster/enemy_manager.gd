extends Node3D

@onready var timer: Timer = $Timer

@export var enemy: PackedScene
@export var enemy_path: Path3D
@export var difficulty_manager: Node
@export var victory_layer: CanvasLayer

func spawn_enemy() -> void:
	var new_enemy = enemy.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_health()
	enemy_path.add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()
	new_enemy.tree_exited.connect(enemy_defeated)


func _on_difficulty_manager_stop_spawning_enemies() -> void:
	timer.stop()

func enemy_defeated() -> void:
	if timer.is_stopped():
		for child in enemy_path.get_children():
			if child is PathFollow3D:
				return
		print("You Won!")
		victory_layer.victory()
