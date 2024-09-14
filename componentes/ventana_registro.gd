extends Node2D

# Cargar el tema desde la carpeta "styles"
var theme_selected = load("res://styles/btn_grado_hover.tres")
var theme_normal = load("res://styles/btn_grado_normal.tres")
@onready var container = $ventana/control_ventana/HBoxContainer  # Nodo contenedor donde están los botones
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btncancelar_pressed() -> void:
	queue_free();
	pass # Replace with function body.


func _on_btnaceptar_pressed() -> void:
	var nombre = $ventana/control_ventana/nombre.text;
	if nombre != '' && Global.nivel != '0': 
		Global.nombre_jugador = nombre;
		Trans.change_scene('res://Escenas/nivel_'+ Global.nivel +'.tscn')
	pass # Replace with function body.


func _on_btn_nivel_pressed(nivel: String) -> void:
	colorear(nivel)
	match nivel:
		'1':
			Global.nivel = '1'
		'2', '3':
			Global.nivel = '2'
		'4', '5':
			Global.nivel = '3'


func colorear(nivel: String):
# Recorrer los botones del 1 al 5
	for i in range(1, 6):  # i va de 1 a 5 (inclusive)
		var button = container.get_node("btn%d" % i)  # Obtener el botón con el nombre btn1, btn2, ..., btn5
		if i == nivel.to_int():
			button.add_theme_stylebox_override("normal", theme_selected)  # Aplica el theme1 al primer botón
		else:
			button.add_theme_stylebox_override("normal", theme_normal)  # Aplica el theme2 a los otros 4 botones
