extends Node2D

@onready var bar_btn : Area2D = $Bar
@onready var casino_btn : Area2D = $Casino
@onready var back_btn : Area2D = $Volver

func _ready():
	bar_btn.input_event.connect(
		Callable(self, "_on_bar_pressed")
	)
	casino_btn.input_event.connect(
		Callable(self, "_on_casino_pressed")
	)
	back_btn.input_event.connect(
		Callable(self, "_on_back_pressed")
	)

func _on_bar_pressed(viewport, event, shape_idx):
	# Aquí cargas la escena del interior del bar
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/InteriorBar.tscn")

func _on_casino_pressed(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/Casino.tscn")

func _on_back_pressed(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/Casa.tscn")
