extends Node2D

# Ruta a tu escena de la SlotMachine
const SLOT_SCENE = "res://scenes/SlotMachine.tscn"

@onready var slot_btn = $SlotButton
@onready var back_btn : Area2D = $Volver
func _ready():
	# Si es un Button:
	if slot_btn is Button:
		slot_btn.pressed.connect(_on_slot_pressed)
	# Si es un Area2D:
	elif slot_btn is Area2D:
		slot_btn.input_event.connect(Callable(self, "_on_slot_pressed_area"), ["fake_arg"])
	back_btn.input_event.connect(
		Callable(self, "_on_back_pressed")
	)

func _on_slot_pressed():
	get_tree().change_scene_to_file(SLOT_SCENE)

# Úsalo solo si SlotButton es un Area2D:
func _on_slot_pressed_area(viewport, event, shape_idx, _arg):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file(SLOT_SCENE)
		
func _on_back_pressed(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/Exterior.tscn")
