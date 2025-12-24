extends Node3D

@export var max_health: int = 5

var current_health: int:
	set(health_in):
		current_health = health_in
		print("Health was changed")
		label_3d.text = str(current_health) + "/" + str(max_health)
		var red = Color.RED
		var white = Color.WHITE
		var health_color = red.lerp(white, float(current_health)/float(max_health))
		label_3d.modulate = health_color
		if current_health < 1:
			get_tree().reload_current_scene()
	

@onready var label_3d: Label3D = $Label3D

func _ready() -> void:
	current_health = max_health
	
func take_demage() -> void:
	print("demage dealt to base!")
	current_health -= 1
