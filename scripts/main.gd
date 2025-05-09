extends Node2D

# CONSULTORIO
@onready var area_laptop : Area2D = $Notebook
@onready var area_papel  : Area2D = $Cuaderno
@onready var area_hablar  : Area2D = $Hablar
@onready var area_diagnosticar  : Area2D = $Diagnosticar


@onready var barras = {
	"concentracion": $CanvasLayer2/Control/Concentracion,
	"empatia":  $CanvasLayer2/Control/Empatia,
	"saludmental":  $CanvasLayer2/Control/SaludMental,
	"energia":  $CanvasLayer2/Control/Energia
}
var last_item: String = ""

func _ready():
	# Conectar señal 'input_event' de cada Area2D
	area_papel.input_event.connect(
		Callable(self, "_on_item_clicked").bind("papel")
	)
	area_laptop.input_event.connect(
		Callable(self, "_on_item_clicked").bind("laptop")
	)
	area_hablar.input_event.connect(
		Callable(self,"_on_item_clicked").bind("hablar")
	)
	area_diagnosticar.input_event.connect(
		Callable(self,"_on_item_clicked").bind("diagnosticar")
	)

func _on_item_clicked(viewport, event, shape_idx, item_id):
	if event is InputEventMouseButton and event.pressed:
		last_item = item_id
		match item_id:
			"papel":
				show_dialog("Revisas las notas del paciente. Detectas un patrón de ansiedad.")
				# al cerrar, podrías +5 a “Comprensión” o algo así
			"laptop":
				show_dialog("Abres el historial digital. Hay varias citas pasadas.")
			"hablar":
				show_dialog("Hablas con el paciente y generas confianza.")
			"diagnosticar":
				show_dialog("Has llegado a un diagnóstico final. ¡Sesión concluida!")

func show_dialog(texto:String):
	print(texto)
	$CanvasLayer/Panel/RichTextLabel.text = texto
	$CanvasLayer/Panel.visible = true
	$CanvasLayer/Panel/Button.pressed.connect(_on_dialog_closed)
	
func _on_dialog_closed():
	# aquí podrías aplicar efectos tras cerrar (ej. actualizar estadística)
	if last_item == "papel":
		barras["concentracion"].value += 5
	elif last_item == "diagnosticar":
			barras["empatia"].value += 10
			GameState.add_money(100)
			get_tree().change_scene_to_file("res://scenes/Casa.tscn")
	elif last_item == "laptop":
			barras["saludmental"].value += 10
	elif last_item == "hablar":
			barras["energia"].value += 10
	$CanvasLayer/Panel.visible = false
