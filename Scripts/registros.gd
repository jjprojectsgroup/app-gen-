extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_data():
	var students = DataManager.load_data()
	if !students.is_empty():
		students.reverse()
		show_data(students)
	else:
		print('No hay registros')


#func show_data(students: Array):
	#for student in students:
		#print(student)
		#print('------------------------')
		## Crear un HBoxContainer para la nueva fila
		#var fila = HBoxContainer.new()
		## Crear etiquetas para cada campo y configurar su texto
		## Cargar la escena de la tarjeta
		#var registro_scene = load("res://componentes/tarjeta_registro.tscn") as PackedScene
		## Instanciar la escena en un nodo
		#var registro = registro_scene.instance() as Control
		#
		## Configurar la etiqueta de la tarjeta
		## Suponiendo que el nodo tiene un Label hijo que muestra el nombre del estudiante
		#var label = registro.get_node("Label")  # Cambia "Label" por la ruta real en la escena
		#label.text = student.name  # Configura el nombre del estudiante
		##registro.text = student.name
		##registro.set_horizontal_alignment(1)
		##registro.set_h_size_flags(3)
		#fila.add_child(registro)
		#$ScrollContainer/contenedor_principal.add_child(fila)

func show_data(students: Array):
	for student in students:
		print(student)
		print('------------------------')
		
		# Crear un HBoxContainer para la nueva fila
		var fila = HBoxContainer.new()
		
		# Cargar la escena de la tarjeta
		var registro_scene = load("res://componentes/tarjeta_registro.tscn")
		
		# Asegurarse de que se ha cargado un PackedScene
		if registro_scene is PackedScene:
			# Instanciar la escena en un nodo
			var registro = registro_scene.instantiate() as Control  # Usar `instantiate()` en lugar de `instance()`
			registro.set_extra_data(student)
			# Actualizar los datos del estudiante en el registro
			update_student_data(registro, student)
			# Establecer márgenes o tamaño mínimo para las tarjetas
			registro.set_custom_minimum_size(Vector2(392, 130))  # Ancho: 200, Alto: 50 (ajusta según tu diseño)
			# Agregar el registro instanciado a la fila
			fila.add_child(registro)
			# Agregar la fila al contenedor principal
			$ScrollContainer/contenedor_principal.add_child(fila)
		else:
			print("Error: No se pudo cargar la escena como PackedScene")

func update_student_data(registro: Control, student: Dictionary):
	# Actualiza múltiples campos del nodo 'registro' con los datos del estudiante
	registro.get_node("Control/nombre").text = student.name
	registro.get_node("Control/grado").text = student.grado
	if  student.actividad_1: 
		registro.get_node("Control/Control1/actividad1").text = 'COMPLETADO'
	if  student.actividad_2:
		registro.get_node("Control/Control2/actividad2").text = 'COMPLETADO' # Datos de respuestas

	var porcentaje = calculate_completion(student)
	print("Porcentaje completado: ", porcentaje, "% por ", student.name)
	registro.get_node("Control/ProgressBar").value = porcentaje
	#registro.get_node("Control/manualidad_1").text = str(student.manualidad_1)  # Ejemplo si es un booleano

# Función para calcular el porcentaje de completado
func calculate_completion(student : Dictionary) -> float:
		# Ejemplo de uso con tus datos
	var booleans = [student.manualidad_1, student.manualidad_2, student.actividad_1, student.actividad_2]  # Datos booleanos (manualidades, actividades)
	var strings = [student.respuesta_1, student.respuesta_2] 
	
	var completed = 0
	var total = booleans.size() + strings.size()  # Total de campos a revisar (4 booleanos + 2 strings)
	# Revisar los booleanos
	for value in booleans:
		if value == true:
			completed += 1
	
	# Revisar los strings
	for value in strings:
		if value != "NO COMPLETADO" && value != "":  # Si el string no está vacío
			completed += 1
	
	# Calcular el porcentaje
	var completion_percentage = (float(completed) / float(total)) * 100
	return completion_percentage
