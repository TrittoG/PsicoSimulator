extends Node2D

# 1) Referencias a los TextureRect de los reel
@onready var reels = [
	$Reels/HBoxContainer/Reel1,
	$Reels/HBoxContainer/Reel2,
	$Reels/HBoxContainer/Reel3
]
@onready var money_label: Label = $CanvasLayer3/MoneyLabel
@onready var back_btn : Area2D = $Volver
@export var spin_cycles: int    = 10     # cuántos cambios de textura
@export var spin_interval: float = 0.05  # segundos entre cada cambio
# 2) Carga de símbolos
var symbols: Array[Texture2D] = []

# Si prefieres, exporta el array y añade las texturas por Inspector:
# @export var symbols: Array[Texture2D]

# Rutas a pre-cargar automáticamente
@export var symbol_paths := [
	"res://assets/cereza.png",
	"res://assets/campana.png",
	"res://assets/siete.png",
	"res://assets/diamante.png"
]

func _ready():
	_update_money_label(GameState._money)
	GameState.money_changed.connect(_update_money_label)
	# Pre-carga todas las texturas
	back_btn.input_event.connect(
		Callable(self, "_on_back_pressed")
	)
	for path in symbol_paths:
		symbols.append( load(path) )

	# Conecta el botón de girar
	$SpinButton.pressed.connect(_on_spin_pressed)

	# Inicializa con valores aleatorios
	_randomize_all_reels()

# 3) Función que aplica un símbolo aleatorio a cada reel
func _randomize_all_reels():
	for reel in reels:
		var idx = randi() % symbols.size()
		reel.texture = symbols[idx]

func _update_money_label(new_money: int) -> void:
	money_label.text = "Dinero: $" + str(new_money)
	
func _on_spin_pressed() -> void:
	# 1) Verificamos que haya al menos $10
	if GameState._money < 10:
		print("No tienes suficiente dinero para girar.")
		return
		
	# 2) Descontamos $10 por jugar
	GameState.add_money(-10)
	
	# 3) Deshabilitamos el botón y lanzamos el giro escalonado
	$SpinButton.disabled = true
	await _spin_reel(reels[0], 2)
	await _spin_reel(reels[1], 5)
	await _spin_reel(reels[2], 8)
	
	# 4) Si ganaste, sumamos $200
	if _check_win():
		GameState.add_money(200)
		print("¡GANASTE! Has recibido $200.")
		# 5) Volvemos a habilitar el botón
	$SpinButton.disabled = false

func _check_win() -> bool:
	var first_tex = reels[0].texture
	for i in range(1, reels.size()):
		if reels[i].texture != first_tex:
			return false
	return true
	
	
# Coroutine que hace “girar” los reels
func _spin_reel(reel: TextureRect, cycles: int) -> void:
	for i in range(cycles):
		reel.texture = symbols[randi() % symbols.size()]
		await get_tree().create_timer(spin_interval).timeout

func _on_back_pressed(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://scenes/Exterior.tscn")
