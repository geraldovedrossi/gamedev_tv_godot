extends PathFollow3D

@export var speed: float = 5
@export var max_health: int = 50
@export var gold_earned: int = 15

@onready var bank = get_tree().get_first_node_in_group("bank")

@onready var base = get_tree().get_first_node_in_group("base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_health: int:
	set(health_in):
		if health_in < max_health:
			animation_player.play("TakeDamage")
		current_health = health_in
		if current_health < 1:
			queue_free()
			bank.gold += gold_earned

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	progress = progress + delta * speed
	if progress_ratio >= 1.0:
		base.take_demage()
		queue_free()
