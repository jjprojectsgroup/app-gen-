extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_respuesta_text_changed(numero: String) -> void:
	var new_text = get_node('Control/respuesta'+numero)
	if new_text.text.length() >= 1:
		new_text.text = new_text.text.substr(0, 1)
		var siguiente = int(numero) + 1
		if siguiente <= 3:
			get_node('Control/respuesta'+ str(siguiente)).grab_focus()
		return

func felicitaciones():
		$ventana_felicidades.visible = true
		$Timer.stop()

func _on_button_pressed() -> void:
	if $Control/respuesta1.text.to_upper() == 'S' && $Control/respuesta2.text.to_upper() == 'O' && $Control/respuesta3.text.to_upper() == 'L': 
		print('respuesta corrrecta')
		$Sol.modulate = Color('ffffff')
		DataManager.update_answer(true, 'actividad_1')
		$Timer.connect("timeout", felicitaciones)
		$Timer.start()

	else:
		print('respuesta incorrrecta')
		
