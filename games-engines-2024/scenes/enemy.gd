extends MeshInstance3D

@onready var tank:Node3D = $"../tank"

func _ready() -> void:
	

	
	pass
	
	
func _process(delta: float) -> void:
	
	var to_player = tank.global_position - global_position
	
	var forw = global_transform.basis.z
	
	DebugDraw3D.draw_arrow(global_position, global_position + forw * 5, Color.AQUA, 0.1)
	DebugDraw2D.set_text("enemy_to_player", to_player)
	DebugDraw2D.set_text("forw", forw)
	
	var axis = to_player.cross(forw)
	
	DebugDraw2D.set_text("axis", axis)
	

	pass
