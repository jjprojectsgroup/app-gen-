extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#OS.request_permission("android.permission.WRITE_EXTERNAL_STORAGE")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func registrar() -> void:
	$boton.play();
	var escena_emergente = preload("res://componentes/ventana_registro.tscn").instantiate()
	get_tree().root.add_child(escena_emergente)


func _on_btndatos_pressed() -> void:
	$boton.play();
	Trans.change_scene('res://Escenas/registros.tscn')	
	#Trans.change_scene('res://Escenas/registros.tscn')


func _on_btnsalir_pressed() -> void:
	$boton.play();
	get_tree().quit();


func _on_hambiente_finished():
	$hambiente.stop();
	$hambiente.play();
