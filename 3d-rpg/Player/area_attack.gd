extends ShapeCast3D

func deal_damage(damage: float, crit_chance: float) -> void:
	for collision in get_collision_count():
		var collider = get_collider(collision)
		if collider is Player or collider is Enemy:
			var is_critical = randf() <= crit_chance
			collider.health_component.take_damage(damage, is_critical)
