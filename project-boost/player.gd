extends RigidBody3D

@export var thrust: float = 1000.0
@export var torque_thrust: float = 100.0
var is_transitioning: bool = false

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var sucess_audio: AudioStreamPlayer = $SucessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var booster_particles_right: GPUParticles3D = $BoosterParticlesRight
@onready var booster_particles_left: GPUParticles3D = $BoosterParticlesLeft
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var sucess_particles: GPUParticles3D = $SuccessParticles

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!is_transitioning):
		if Input.is_action_pressed("boost"):
			apply_central_force(basis.y * delta * thrust)
			if !rocket_audio.playing:
				rocket_audio.play()
			if !booster_particles.emitting:
				booster_particles.emitting = true
		else:
			rocket_audio.stop()
			booster_particles.emitting = false

		if Input.is_action_pressed("turn_left"):
			apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
			if !booster_particles_left.emitting:
				booster_particles_left.emitting = true
		else:
			booster_particles_left.emitting = false
			
		if Input.is_action_pressed("turn_right"):
			apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))
			if !booster_particles_right.emitting:
				booster_particles_right.emitting = true
		else:
			booster_particles_right.emitting = false
			
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()


func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups():
		complete_level(body.file_path)
		
	if "Hazards" in body.get_groups():
		crash_sequence()

func crash_sequence() -> void:
	print("You crashed!!!")
	explosion_audio.play()
	explosion_particles.emitting = true
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(explosion_audio.stream.get_length())
	tween.tween_callback(get_tree().reload_current_scene)

func complete_level(next_level_file: String) -> void:
	print("You Win!!!")
	sucess_audio.play()
	sucess_particles.emitting = true
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(sucess_audio.stream.get_length())
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))
	
