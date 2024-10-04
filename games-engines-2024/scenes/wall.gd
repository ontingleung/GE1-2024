extends Node3D

@export var brick_scene: PackedScene
@export var rows = 20  # Number of rows in each tower
@export var cols = 20  # Number of bricks per row
@export var brick_size = Vector3(1, 0.5, 0.5)  # Size of each brick
@export var row_offset = 0.5  # Offset for staggered row effect
@export var wall_distance = 10  # Distance between the two walls

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create two walls
	create_wall(Vector3(0, 0, 0))  # First wall at (0, 0, 0)
	create_wall(Vector3(wall_distance, 0, 0))  # Second wall at some distance
	
	pass

# Function to create a wall with bricks at a specific position
func create_wall(offset: Vector3) -> void:
	for row in range(rows):
		# Offset for staggered brick placement
		var row_x_offset = (row % 2) * row_offset
		
		for col in range(cols):
			var brick = brick_scene.instantiate()
			
			# Position bricks in 3D space with the given offset
			var pos = Vector3((col * brick_size.x) + row_x_offset, 0, row * brick_size.z) + offset
			brick.position = pos
			
			# Store the original position for respawning later
			brick.set("original_position", pos)
			
			# Assign a unique material (optional, for visual variety)
			var m = StandardMaterial3D.new()
			var h = ((row * cols) + col) / float(rows * cols)
			m.albedo_color = Color.from_hsv(h, 1, 1)
			
			# Get the mesh instance for the brick and set the material
			var mesh: MeshInstance3D = brick.get_node("MeshInstance3D")
			mesh.set_surface_override_material(0, m)
			
			# Add the brick to the scene
			add_child(brick)
	
	pass
