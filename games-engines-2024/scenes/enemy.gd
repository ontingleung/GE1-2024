extends MeshInstance3D

@onready var tank:Node3D = $"../tank"

var to_player
var forw
var axis
var theta

var q1:Quaternion
var q2:Quaternion
var t

f
adsf

func _ready() -> void:
	
	to_player = global_position - tank.global_position 
	to_player = to_player.normalized()
	forw = global_transform.basis.z
	
	DebugDraw3D.draw_arrow(global_position, global_position + forw * 5, Color.AQUA, 0.1)
	DebugDraw2D.set_text("enemy_to_player", to_player)
	DebugDraw2D.set_text("forw", forw)
	axis = to_player.cross(forw)
	theta = acos(to_player.dot(forw))
	
	q2 = Quaternion(axis, theta)
	q1 = global_basis.get_rotation_quaternion()
	t = 0
	

	
	pass
	
	
func _process(delta: float) -> void:
	
	var q:Quaternion
	
	if (t < 1.0):
		t = t + delta
		q = q1.slerp(q2, t)
		global_basis = Basis(q)
		rotation = Vector3(0, t, 0)

	else:
		q = q1.slerp(q2, t)
		global_basis = Basis(q)
		rotation = Vector3(0, t, 0)
		
		


	pass
