extends CharacterBody3D

@export var speed:float = -1
@export var rot_speed = 180.0

@export var bullet_scene:PackedScene
@export var bullet_spawn:Node3D

@export var color_change_speed:float = 1.0  # Speed of the rainbow effect

# Track the hue value (0-1 range)
var hue:float = 0.0

# Reference to the material of the tank (make sure to assign it in _ready)
var tank_material:StandardMaterial3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Assuming the tank's mesh is a child node, find it and access its material
	var mesh_instance = $TankMesh  # Adjust this to the correct path of your tank's MeshInstance3D
	if mesh_instance:
		tank_material = mesh_instance.get_surface_override_material(0)
		if tank_material == null:
			# If no override material, duplicate the existing one
			tank_material = mesh_instance.get_material_override(0).duplicate()
			mesh_instance.set_surface_override_material(0, tank_material)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	# Movement
	var f = Input.get_axis("move_back", "move_forward")
	var v = global_transform.basis.z	
	velocity = v * speed * f
	move_and_slide()

	# Rotation
	var r = Input.get_axis("turn_left", "turn_right")
	rotate_y(-deg_to_rad(rot_speed) * r * delta)

	# Update rainbow color loop
	hue += delta * color_change_speed
	if hue > 1.0:
		hue -= 1.0  # Loop the hue back to 0 after reaching 1 (full spectrum)

	# Convert hue to RGB and apply it to the material's albedo color
	if tank_material:
		var rainbow_color = Color.from_hsv(hue, 1.0, 1.0)  # Full saturation and brightness
		tank_material.albedo_color = rainbow_color  # Change the material color

	# Debugging (optional)
	DebugDraw2D.set_text("position", position)
	DebugDraw2D.set_text("global_position", position)
	DebugDraw2D.set_text("basis.x", transform.basis.x)
	DebugDraw2D.set_text("basis.y", transform.basis.y)
	DebugDraw2D.set_text("basis.z", transform.basis.z)
	DebugDraw2D.set_text("glo basis.x", global_transform.basis.x)
	DebugDraw2D.set_text("glo basis.y", global_transform.basis.y)
	DebugDraw2D.set_text("glo basis.z", global_transform.basis.z)
	
	# Shooting bullets
	if Input.is_action_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = bullet_spawn.global_position
		bullet.global_rotation = global_rotation
