extends Node

var file_path = "user://students_data.json"

# Cargar los datos desde el archivo JSON
func load_students_data() -> Array:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		#var data = JSON.parse(file.get_as_text()).result
		var data = file.get_var()
		file.close()
		return data
	return []

# Guardar los datos en el archivo JSON
func save_students_data(students_data: Array):
	var file = FileAccess
	file.open(file_path, FileAccess.WRITE)
	#file.store_string(JSON.print(students_data))
	#file.close()

# Agregar un nuevo estudiante
func add_student(name: String, grade: String, answers: Array):
	var students = load_students_data()
	var new_student = {"name": name, "grade": grade, "answers": answers}
	students.append(new_student)
	save_students_data(students)

# Editar el último estudiante
func edit_last_student(new_name: String, new_grade: String, new_answers: Array):
	var students = load_students_data()
	if students.size() > 0:
		var last_student = students[students.size() - 1]
		last_student["name"] = new_name
		last_student["grade"] = new_grade
		last_student["answers"] = new_answers
		students[students.size() - 1] = last_student
		save_students_data(students)
