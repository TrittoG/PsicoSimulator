extends Node2D

@onready var salir_btn : Area2D = $Salir
@onready var avanzar_btn : Area2D = $Volver
@onready var money_label: Label = $CanvasLayer3/MoneyLabel

func _ready():
	_update_money_label(GameState._money)
	GameState.money_changed.connect(_update_money_label)
	salir_btn.input_event.connect(
		Callable(self, "_on_salir_pressed")
	)
	avanzar_btn.input_event.connect(
		Callable(self, "_on_volver_pressed")
	)
	
func _update_money_label(new_money: int) -> void:
	money_label.text = "Dinero: $" + str(new_money)
	
func _on_salir_pressed(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
	# Aquí cargas la escena del interior del bar
		get_tree().change_scene_to_file("res://scenes/Exterior.tscn")

func _on_volver_pressed(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
