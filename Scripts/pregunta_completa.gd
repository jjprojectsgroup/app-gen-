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
	$boton.play();
	if $Control/respuesta1.text.to_upper() == 'S' && $Control/respuesta2.text.to_upper() == 'O' && $Control/respuesta3.text.to_upper() == 'L': 
		#print('respuesta corrrecta')
		cambiar_color('4dff4e')
		$Sol.modulate = Color('ffffff')
		DataManager.update_answer(true, 'actividad_1')
		$Timer.connect("timeout", felicitaciones)
		$Timer.start()
	else:
		#print('respuesta incorrrecta')
		cambiar_color('eb1e1e')
		

func cambiar_color(color:String):
	if $TimerColor.is_connected('timeout', cambiar_color_original):
		$TimerColor.disconnect('timeout', cambiar_color_original)
	$Control/respuesta1.modulate = Color(color)
	$Control/respuesta2.modulate = Color(color)
	$Control/respuesta3.modulate = Color(color)
	$TimerColor.connect("timeout", cambiar_color_original)
	$TimerColor.start()

func cambiar_color_original():
	$Control/respuesta1.modulate = Color('ffffff')
	$Control/respuesta2.modulate = Color('ffffff')
	$Control/respuesta3.modulate = Color('ffffff')
	$TimerColor.stop()
	$TimerColor.disconnect('timeout', cambiar_color_original)


func _on_hambiente_finished() -> void:
	$hambiente.stop();
	$hambiente.play();
