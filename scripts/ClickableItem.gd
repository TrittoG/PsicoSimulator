extends Area2D

@export var hover_factor: float = 1.15  # 15% más grande
# Si quisieras distintas escalas X e Y: export var hover_factor: Vector2 = Vector2(1.15, 1.15)

# Guarda la escala original
var original_scale: Vector2

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	# captura la escala actual del sprite como “original”
	original_scale = sprite.scale

	# conecta las señales de hover
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	sprite.scale = original_scale * hover_factor

func _on_mouse_exited():
	sprite.scale = original_scale
