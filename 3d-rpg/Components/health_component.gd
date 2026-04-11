extends Node
class_name HealthComponent

signal defeat()
signal health_changed()

@export var body: PhysicsBody3D

var max_health: float
var current_health: float:
	set(value):
		current_health = max(value, 0.0)
		if current_health == 0.0:
			defeat.emit()
		health_changed.emit()
		
func update_max_health(max_hp_in: float) -> void:
	max_health = max_hp_in
	current_health = max_health

func take_damage(damage_in: float, is_critical: bool) -> void:
	var damage = damage_in
	var color: Color
	var position_in = body.global_position
	if is_critical:
		damage *= 2.0
		print("Critical")
		print("Damage dealead: " + str(damage))
		color = Color.RED
	else:
		print("Damage dealead: " + str(damage))
		color = Color.WHITE
	current_health -= damage
	if body is Enemy:
		position_in.y += 1.5
	VfxManager.spawn_damage_number(damage, color, position_in)

func get_health_string() -> String:
	return str(int(current_health)) + " / " + str(int(max_health))
