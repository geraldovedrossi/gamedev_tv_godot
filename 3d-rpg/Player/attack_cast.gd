extends RayCast3D

func deal_damage() -> void:
	if not is_colliding():
		return
	var collider = get_collider()
	
	if collider is Enemy:
		printt(collider, "Max HP: ", collider.max_health)
		collider.health_component.take_damage(15.0)
		add_exception(collider)
