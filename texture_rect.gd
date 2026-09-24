extends TextureRect

# ==========================================
# CONFIGURAÇÕES DA PORTA / CHAVE
# ==========================================
@export var tipo_porta: String = "OR"

# ==========================================
# AJUSTE DA POSIÇÃO NO ENCAIXE
# ==========================================
@export var ajuste_x: float = 0.0
@export var ajuste_y: float = 0.0

# ==========================================
# VARIÁVEIS INTERNAS
# ==========================================
var posicao_inicial: Vector2
var tamanho_original: Vector2
var encaixada: bool = false


func _ready() -> void:
	posicao_inicial = global_position
	tamanho_original = size # Guarda o tamanho original da peça


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
		var posicao_destino = no_alvo.global_position + Vector2(ajuste_x, ajuste_y)

		# Garante que a peça mantenha suas dimensões exatas durante a animação
		custom_minimum_size = tamanho_original
		size = tamanho_original

		var tween = create_tween().set_parallel(true)
		
		# Anima a posição
		tween.tween_property(
			self,
			"global_position",
			posicao_destino,
			0.4
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		# Força a manutenção do tamanho correto
		tween.tween_property(
			self,
			"size",
			tamanho_original,
			0.4
		)

		await tween.finished

		if cena_principal.has_method("validar_jogada"):
			cena_principal.validar_jogada(self)


func voltar_para_origem() -> void:
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(
		self,
		"global_position",
		posicao_inicial,
		0.3
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		self,
		"size",
		tamanho_original,
		0.3
	)
