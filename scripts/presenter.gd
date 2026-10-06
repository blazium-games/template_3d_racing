extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()
var along := 0.0
var rival_along := 1.2
var rival_mark: MeshInstance3D

@onready var oval_car: MeshInstance3D = $OvalCar

func _ready() -> void:
	for i in 12:
		var slab := MeshInstance3D.new()
		var box_mesh := BoxMesh.new()
		box_mesh.size = Vector3(2, 0.1, 2)
		slab.mesh = box_mesh
		var angle := float(i) / 12.0 * TAU
		slab.position = Vector3(sin(angle) * 6.0, 0, cos(angle) * 6.0)
		add_child(slab)
	rival_mark = MeshInstance3D.new()
	var rival_mesh := BoxMesh.new()
	rival_mesh.size = Vector3(1.0, 0.4, 1.8)
	rival_mark.mesh = rival_mesh
	add_child(rival_mark)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("stride_north"):
		along = fposmod(along + _delta, TAU)
	oval_car.position = Vector3(sin(along) * 6.0, 0.4, cos(along) * 6.0)
	var mid := absf(along - PI) < 0.35
	rules.note_mid(mid)
	var touching := along < 0.35 or along > TAU - 0.35
	rules.note_stripe(touching)
	rival_along = fposmod(rival_along + _delta * 0.35, TAU)
	rival_mark.position = Vector3(sin(rival_along) * 6.0, 0.45, cos(rival_along) * 6.0)
	if rules.may_finish():
		_go("res://scenes/finish.tscn")

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
