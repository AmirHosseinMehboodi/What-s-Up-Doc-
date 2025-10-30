extends Area2D

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# Make sure it's the player (or any object that supports this method)
	if body.has_method("set_gravity_multiplier"):
		# Increase gravity strength (e.g., 3x normal)
		body.set_gravity_multiplier(3.5)

		# Optional: remove the player's collision shape
		var shape = body.get_node_or_null("CollisionShape2D")
		if shape:
			shape.queue_free()

		# Add slow motion and start timer
		Engine.time_scale = 0.5
		timer.start()

func _on_timer_timeout() -> void:
	# Restore time and reload scene
	Engine.time_scale = 1
	get_tree().reload_current_scene()
