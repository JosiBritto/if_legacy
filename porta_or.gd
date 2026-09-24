extends TextureRect

# ==========================================
# CONFIGURAÇÃO DA PORTA OR
# ==========================================
var tipo_porta: String = "OR"

# Ajusta os valores de X e Y no Inspector para centralizar perfeitamente sobre o circuito
@export var ajuste_x: float = -177
@export var ajuste_y: float = -29

var posicao_inicial: Vector2
var tamanho_original: Vector2
var encaixada: bool = false
var posicao_capturada: bool = false


func _ready() -> void:
	tamanho_original = size


func _process(_delta: float) -> void:
	if not posicao_capturada and global_position != Vector2.ZERO:
		posicao_inicial = global_position
		posicao_capturada = true


func _gui_input(event: InputEvent) -> void:
	if encaixada:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mover_para_alvo_e_validar()


func mover_para_alvo_e_validar() -> void:
	var cena_principal = get_tree().current_scene

	var nome_do_alvo: String = ""
	if "alvo_atual" in cena_principal:
		nome_do_alvo = cena_principal.alvo_atual

	if nome_do_alvo == "":
		return

	var no_alvo = cena_principal.find_child(nome_do_alvo, true, false)

	if no_alvo != null:
		top_level = true
		z_index = 10

		var centro_alvo = no_alvo.global_position + (no_alvo.size / 2.0)
		var posicao_destino = centro_alvo - (tamanho_original / 2.0) + Vector2(ajuste_x, ajuste_y)

		custom_minimum_size = tamanho_original
		size = tamanho_original

		var tween = create_tween().set_parallel(true)

		tween.tween_property(
			self,
			"global_position",
			posicao_destino,
			0.4
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		await tween.finished

		if cena_principal.has_method("validar_jogada"):
			cena_principal.validar_jogada(self)


func voltar_para_origem() -> void:
	var tween = create_tween().set_parallel(true)

	tween.tween_property(
		self,
		"global_position",
		posicao_inicial,
		0.4
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	await tween.finished
	z_index = 1
