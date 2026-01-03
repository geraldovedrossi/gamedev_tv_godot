extends Node3D

@export var weapon_demage := 10
@export var fire_rate := 14.0
@export var recoil := 0.01
@export var weapon_mesh: Node3D
@export var muzzle_flash: GPUParticles3D
@export var sparks: PackedScene

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d: RayCast3D = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		if cooldown_timer.is_stopped():
			shoot()
			
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * 10.0)

func shoot() -> void:
	muzzle_flash.restart()
	cooldown_timer.start(1.0 / fire_rate)
	weapon_mesh.position.z += recoil
	
	var collider = ray_cast_3d.get_collider()
	if collider is Enemy:
		collider.current_hp -= weapon_demage
		print("Hit the enemy!")
	
	var spark = sparks.instantiate()
	add_child(spark)
	spark.global_position = ray_cast_3d.get_collision_point()
	spark.emitting = true
