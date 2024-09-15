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
	#print(JSON.stringify(students))
	file.close()


func load_data() -> Array:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file && file.get_as_text() != null && file.get_as_text() != 'null':
		#print(file.get_as_text())
		var data : Array = str_to_var(file.get_as_text())
		file.close()
		return data;
	return []

func update_answer(answer: String, question: String) -> bool:
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	var students : Array = str_to_var(file.get_as_text())
	var player = students[students.size() - 1]
	player[question] = answer
	students[player.size() - 1] = player
	file.store_string(JSON.stringify(students))
	return true

## Agregar un nuevo estudiante
#func add_student(name: String, grade: String, answers: Array):
	#var students = load_students_data()
	#var new_student = {"name": name, "grade": grade, "answers": answers}
	#students.append(new_student)
	#save_students_data(students)

## Cargar los datos desde el archivo JSON
#func load_students_data() -> Array:
	#var file = FileAccess.open(file_path, FileAccess.READ)
	#if file:
		##var data = JSON.parse(file.get_as_text()).result
		#var data = file.get_var()
		#file.close()
		#return data
	#return []
#
## Guardar los datos en el archivo JSON
#func save_students_data(students_data: Array):
	#var file = FileAccess
	#file.open(file_path, FileAccess.WRITE)
	##file.store_string(JSON.print(students_data))
	##file.close()
#

#
## Editar el último estudiante
#func edit_last_student(new_name: String, new_grade: String, new_answers: Array):
	#var students = load_students_data()
	#if students.size() > 0:
		#var last_student = students[students.size() - 1]
		#last_student["name"] = new_name
		#last_student["grade"] = new_grade
		#last_student["answers"] = new_answers
		#students[students.size() - 1] = last_student
		#save_students_data(students)
