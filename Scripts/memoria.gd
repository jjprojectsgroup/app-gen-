extends Node2D

var par = [] # Almacena temporalmente los botones emparejados
var par_count = 0 # Contador para verificar cuántos pares se han encontrado
var is_validating = false
var total_pairs = 6 # Cambia esto según el número de pares totales en el juego

func _ready() -> void:
	hide_felicidades() # Asegúrate de que la ventana esté oculta al inicio

func _on_card_pressed(card: String, button_name: String) -> void:
	if is_validating or par.size() >= 2:
		return
	par.append([card, button_name])
	disabled_selected_card(button_name)
	play_card_animation(button_name, false)
	if par.size() >= 2:
		is_validating = true
		if par[0][0] == card:
			flat_selected_card(button_name, false)
			flat_selected_card(par[0][1], false)
			par_count += 1
			check_game_complete() # Revisa si ya se han emparejado todas las tarjetas
		else:
			await get_tree().create_timer(1.0).timeout
			play_card_animation(button_name, true)
			play_card_animation(par[0][1], true)
			enabled_selected_card(button_name)
			enabled_selected_card(par[0][1])
		par.clear()
		is_validating = false

func check_game_complete() -> void:
	if par_count == total_pairs:
		show_felicidades() # Muestra la ventana de felicitaciones si se completan todos los pares

func disabled_selected_card(button_name: String) -> void:
	var button_path = "%s/%s" % ['Card'+button_name, 'Button']
	var button = get_node(button_path)
	button.disabled = true
	button.flat = false

func enabled_selected_card(button_name: String) -> void:
	var button_path = "%s/%s" % ['Card'+button_name, 'Button']
	var button = get_node(button_path)
	button.disabled = false
	button.flat = true

func flat_selected_card(button_name: String, flat: bool) -> void:
	var button_path = "%s/%s" % ['Card'+button_name, 'Button']
	var button = get_node(button_path)
	button.flat = flat

func play_card_animation(button_name: String, reverse: bool) -> void:
	var card_path = "%s" % 'Card'+button_name
	var card = get_node(card_path)
	var anim_player = card.get_node("AnimationPlayer")

	if reverse:
		anim_player.play_backwards("voltear")
	else:
		anim_player.play("voltear")

# Función para mostrar la ventana de felicitaciones
func show_felicidades() -> void:
	var ventana_felicidades = get_node("ventana_felicidades")
	ventana_felicidades.show()

# Función para ocultar la ventana de felicitaciones al inicio del juego
func hide_felicidades() -> void:
	var ventana_felicidades = get_node("ventana_felicidades")
	ventana_felicidades.hide()
