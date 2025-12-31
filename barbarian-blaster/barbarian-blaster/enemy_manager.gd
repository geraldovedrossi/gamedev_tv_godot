extends Node3D

@export var enemy: PackedScene
@export var enemy_path: Path3D
var count: int = 0
	
func _ready() -> void:
	spawn_enemy()

func _on_timer_timeout() -> void:
	var timer = self.get_children()[0]
	spawn_enemy()
	count += 1
	if count >= 5 && timer.wait_time > 0.4:
		count = 0
		print("Acelerando!")
		timer.wait_time -= 0.1
	#pass
	

func spawn_enemy() -> void:
	var new_enemy = enemy.instantiate()
	enemy_path.add_child(new_enemy)
