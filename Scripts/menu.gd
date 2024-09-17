extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func registrar() -> void:
	var escena_emergente = preload("res://componentes/ventana_registro.tscn").instantiate()
	get_tree().root.add_child(escena_emergente)


func _on_btndatos_pressed() -> void:
	Trans.change_scene('res://Escenas/registros.tscn')
