extends Node2D

var preguntas_nivel_1 = [
	"¿Qué es contaminación?",
	"¿Qué acciones puedes hacer en tu casa para que este mundo no sea como el de Wall-E?",
];

var preguntas_nivel_2 = [
	"¿Cómo pueden ayudar al Señor + al salvar el planeta?",
	"¿Qué acciones puedes hacer en tu casa para que este mundo no sea como el de Wall-E?",
];


var preguntas_nivel_3 = [
	"¿Cómo se veria nuestro planeta si no cambiamos nuestra forma de tratar al medio ambiente?",
	"¿Será que llegaremos a un mundo como el de Wall-E? Justifica tu respuesta.",
];
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
			$Control/pregunta.text = preguntas[0]
		'2':
			$Control/pregunta.text = preguntas[1]


func _on_guardar_pressed() -> void:
	print($Control/fondo_respuesta/respuesta.text)
	Trans.change_scene('res://Escenas/nivel_'+ Global.nivel +'.tscn')
	pass # Replace with function body.
