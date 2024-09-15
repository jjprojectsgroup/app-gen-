extends Node2D


var word_positions = {
	"contaminacion": ['letra_9', 'letra_18', 'letra_27', 'letra_36', 'letra_45', 'letra_54', 'letra_63', 'letra_72', 'letra_81', 'letra_90', 'letra_99', 'letra_108', 'letra_117'],
	"planeta": ['letra_75','letra_76','letra_77','letra_78','letra_79','letra_80','letra_81'],
	"futuro": ['letra_11', 'letra_21', 'letra_31', 'letra_41', 'letra_51', 'letra_61'],
	"desechos": ['letra_101', 'letra_92', 'letra_83', 'letra_74', 'letra_65', 'letra_56', 'letra_47', 'letra_38'],
	"salud": ['letra_58', 'letra_67', 'letra_76', 'letra_85', 'letra_94'],
	"reciclar": ['letra_109', 'letra_110', 'letra_111', 'letra_112', 'letra_113', 'letra_114', 'letra_115', 'letra_116'],
	"reusar": ['letra_19', 'letra_20', 'letra_21', 'letra_22', 'letra_23', 'letra_24'],
	"reducir": ['letra_8', 'letra_17', 'letra_26', 'letra_35', 'letra_44', 'letra_53', 'letra_62'],
}
var found_words = 0;  # contador de palabras ya encontradas
var pressed_buttons = []  # Lista para almacenar los identificadores de botones presionados
var button_states = {}    # Diccionario para almacenar el estado de los botones
var theme_selected = load("res://styles/btn_letras.tres")
var theme_normal = load("res://styles/btn_letras_normal.tres")
var button_container_path = "fondo2"
var found_buttons = []  # Almacena los botones que pertenecen a palabras encontradas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Conectar la señal de todos los botones en el grupo "letter_buttons"
	var buttons = get_tree().get_nodes_in_group("letter_buttons")
	for button in buttons:
		button.button_down.connect(_on_button_pressed.bind(button.name))
		button_states[button.name] = "normal"  # Inicializa el estado del botón
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Función llamada cuando un botón es presionado
func _on_button_pressed(button_id: String):
	pressed_buttons.append(button_id)
	update_button_styles()
	check_word(pressed_buttons)
	# Llama a la función para verificar la secuencia cada vez que se presiona un botón
	check_sequence()


# Verifica si la secuencia de botones presionados forma alguna palabra en el diccionario
func check_word(pressed_buttons: Array):
	for word in word_positions.keys():
		if is_correct_sequence(word, pressed_buttons):
			var palabra_path = "%s/%s" % ['palabras', word] 
			count_found_words()
			var palabra = get_node(palabra_path)
			palabra.modulate = Color.FOREST_GREEN
			# Añadir los botónes al registro de botones encontrados
			for button_name in pressed_buttons:
				if not button_name in found_buttons:
					found_buttons.append(button_name)
			pressed_buttons.clear()
			return
	#print("Palabra no encontrada o secuencia incorrecta.")

func count_found_words():
	found_words+=1;
	if found_words >= 8:
		print('Todas las palabras encontradas')
	else:
		var count = 8 - found_words
		print('Faltan ' + str(count) + ' palabras')
	
# Comprueba si la secuencia de botones presionados coincide con la secuencia esperada para una palabra
func is_correct_sequence(word: String, pressed_buttons: Array) -> bool:
	var correct_sequence = word_positions[word]
	# Verifica si la secuencia presionada coincide con la secuencia correcta
	if pressed_buttons.size() != correct_sequence.size():
		return false
	for i in range(pressed_buttons.size()):
		if pressed_buttons[i] != correct_sequence[i]:
			return false
	return true
	
func update_button_styles():
	var correct_sequence = get_correct_sequence(pressed_buttons)
	for button_name in button_states.keys():
		var button_path = "%s/%s" % [button_container_path, button_name] 
		var button = get_node(button_path)
		if button_name in pressed_buttons:
			if correct_sequence and button_name in correct_sequence:
				print('cambio de color')
				button.add_theme_stylebox_override("normal", theme_selected)


# Obtiene la secuencia correcta si la secuencia actual es válida
func get_correct_sequence(pressed_buttons: Array) -> Array:
	for word in word_positions.keys():
		var correct_sequence = word_positions[word]
		if is_correct_sequence(word, pressed_buttons):
			return correct_sequence
	return []

# Función para verificar la secuencia de botones presionados
func check_sequence():
	var sequence_found = false  # Bandera para verificar si la secuencia es válida
	for word in word_positions.keys():
		var correct_sequence = word_positions[word]
	# Verifica si la secuencia presionada coincide con el inicio de alguna palabra
		if pressed_buttons == correct_sequence.slice(0, pressed_buttons.size()):
			sequence_found = true
			# Aplicar el estilo theme_selected a los botones presionados
			for button_name in pressed_buttons:
				var button_path = "fondo2/%s" % button_name
				var button = get_node(button_path)
				button.add_theme_stylebox_override("normal", theme_selected)
			break  # Si se encuentra una coincidencia, no se necesita seguir buscando
	# Si no se encontró ninguna coincidencia, imprime que la palabra no existe
	if not sequence_found:
		for button_name in pressed_buttons:
			# Solo desmarcar el botón si no está en la lista de botones encontrados
			if not button_name in found_buttons:
					var button_path = "fondo2/%s" % button_name
					var button = get_node(button_path)
					button.add_theme_stylebox_override("normal", theme_normal)
		pressed_buttons.clear()
