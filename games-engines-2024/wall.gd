extends Node3D

@export var brick_scene:PackedScene
@export var rows = 10
@export var cols = 10
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for row in range(rows):
		for col in range(cols):
			var brick = brick_scene.instantiate()
			
			var pos = Vector3(col, row, 0)
			var r = rng.randf_range(0, 255.0)
			var g = rng.randf_range(0, 255.0)
			var b = rng.randf_range(0, 255.0)
			
			brick.position = pos
			#brick = brick.get_node("Brick")
			#brick.mesh.material
			#brick.y = Vector3(0, 1, 0) # Vector pointing along the Y axis
			#brick.z = Vector3(0, 0, 1)
			#MeshInstance3D.material.albedo_color = Color(r, g, b, 1)
			add_child(brick)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
