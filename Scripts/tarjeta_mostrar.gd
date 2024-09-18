extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$boton.play();
	queue_free();

func get_data(student: Dictionary):
	$Label/Control/nombre.text = student.name
	$Label/Control/grado.text = student.grado
	$Label/Control/respuesta1.text = student.respuesta_1
	$Label/Control/respuesta2.text = student.respuesta_2
