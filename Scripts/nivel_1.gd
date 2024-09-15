extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#DataManager.save_data()
	DataManager.load_data()
	$Control/panel_datos.text = '¡Hola '+ Global.nombre_jugador + '!  Bienvenido a GEN+. ¡Prepárate para aprender y divertirte!'
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_btnsalir_pressed() -> void:
	Trans.change_scene('res://Escenas/menu.tscn')
	pass # Replace with function body.


func _on_btnactividad_1_pressed() -> void:
	Global.numero_video = '1';
	Trans.change_scene('res://Escenas/videos.tscn')
	pass # Replace with function body.


func _on_btnactividad_2_pressed() -> void:
	Global.numero_video = '2';
	Trans.change_scene('res://Escenas/videos.tscn')
	pass # Replace with function body.


func _on_btnpregunta_pressed(numero: String) -> void:
	Global.numero_pregunta = numero;
	Trans.change_scene('res://Escenas/preguntas.tscn')
