# GameState.gd
extends Node

@export var starting_money: int = 10

var _money: int = 0

signal money_changed(new_money)

func _ready():
	# Inicializa el dinero
	_money = starting_money

func set_money(value: int) -> void:
	_money = value
	emit_signal("money_changed", _money)

func add_money(amount: int) -> void:
	set_money(_money + amount)
