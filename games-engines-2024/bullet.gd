extends CharacterBody3D

@export var speed:float = 20

func _physics_process(delta: float) -> void:
	var v = global_transform.basis.z
	var collision = move_and_collide(v * speed * delta)
	
	# Check if a collision happened
	if collision:
		var collider = collision.get_collider()
		
		# If the collider is a brick, handle respawning
		if collider.has_method("respawn"):
			collider.respawn()

		# You might want to reset or remove the bullet after collision
		queue_free()  # Destroys the bullet after collision
