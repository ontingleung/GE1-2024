extends Node3D

@export var brick_scene:PackedScene
@export var num_bricks = 20  # Number of bricks to arrange in a circle
@export var radius = 5.0  # Radius of the circle
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	for i in range(num_bricks):
		# Instantiate a new brick
		var brick = brick_scene.instantiate()
		
		# Calculate the angle for each brick in the circle
		var angle = (i / float(num_bricks)) * PI * 2.0  # Full circle is 2 * PI radians
		
		# Calculate the position using polar coordinates
		var x = radius * cos(angle)
		var z = radius * sin(angle)
		var pos = Vector3(x, 0, z)  # Set the Y value to 0 for a flat circle
		
		brick.position = pos
		
		# Access the MeshInstance3D node (assuming it's called "Brick")
		var mesh_instance = brick.get_node("Brick")
		
		if mesh_instance and mesh_instance is MeshInstance3D:
			# Create a new material
			var material = StandardMaterial3D.new()
			
			# Generate random colors
			var r = rng.randf_range(0, 1.0)
			var g = rng.randf_range(0, 1.0)
			var b = rng.randf_range(0, 1.0)
			
			# Set the albedo (diffuse color) of the material
			material.albedo_color = Color(r, g, b, 1)
			
			# Assign the material to the mesh instance
			mesh_instance.material_override = material
		
		# Add the brick to the scene
		add_child(brick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
