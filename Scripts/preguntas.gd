extends Node2D

var preguntas_nivel_1 = [
	["¿Qué es contaminación?", "res://img/10.png"],
	["¿Qué acciones puedes hacer en tu casa para que este mundo no sea como el de Wall-E?", "res://img/9.png"],
];

var preguntas_nivel_2 = [
	["¿Cómo pueden ayudar al Señor + al salvar el planeta?", "res://img/10.png"],
	["¿Qué acciones causaron que el mundo se transformara como el de Wall-E?", "res://img/9.png"],
];


var preguntas_nivel_3 = [
	["¿Cómo se veria nuestro planeta si no cambiamos nuestra forma de tratar al medio ambiente?", "res://img/10.png"],
	["¿Será que llegaremos a un mundo como el de Wall-E? Justifica tu respuesta.", "res://img/9.png"],
];

var pregunta_actual = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/imagen/imagen_pregunta.scale = Vector2(0.45, 0.54)
	_preguntar()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _preguntar():
	var preguntas = [];
	match Global.nivel:
		'1':
			preguntas = preguntas_nivel_1
		'2':
			preguntas = preguntas_nivel_2
		'3':
			preguntas = preguntas_nivel_3
	match Global.numero_pregunta:
		'1':
			$Control/pregunta.text = preguntas[0][0]
			$Control/imagen/imagen_pregunta.texture = load(preguntas[0][1])
			pregunta_actual = 'respuesta_1'
		'2':
			$Control/pregunta.text = preguntas[1][0]
			$Control/imagen/imagen_pregunta.texture = load(preguntas[1][1])
			pregunta_actual = 'respuesta_2'



func _on_guardar_pressed() -> void:
	DataManager.update_answer($Control/fondo_respuesta/respuesta.text, pregunta_actual)
	Trans.change_scene('res://Escenas/nivel_'+ Global.nivel +'.tscn')
