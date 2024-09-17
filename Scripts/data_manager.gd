extends Node

var file_path = "res://save_data.json"

func save_data():
	var nombre = Global.nombre_jugador
	var grado = Global.grado_jugador
	var user_data : Dictionary = {
		name = nombre,
		grado = grado,
		respuesta_1 = 'NO COMPLETADO',
		respuesta_2 = 'NO COMPLETADO',
		manualidad_1 = false,
		manualidad_2 = false,
		actividad_1 = false,
		actividad_2 = false,
	}

	var students = load_data()
	if students == null:
		students = []
		students.append(user_data)
	else:
		students.append(user_data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(students))
	file.close()


func load_data() -> Array:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file && !file.get_as_text().is_empty():
		var data : Array = str_to_var(file.get_as_text())
		file.close()
		return data;
	return []

func update_answer(answer, question: String) -> bool:
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	var students : Array = str_to_var(file.get_as_text())
	var player = students[students.size() - 1]
	player[question] = answer
	students[students.size() - 1] = player
	file.store_string(JSON.stringify(students))
	return true
