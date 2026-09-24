extends Control

# ==========================================
# CONFIGURAÇÕES DE VIDA E ETAPAS
# ==========================================
@export var vidas_maximas: int = 3
var vidas_atuais: int

# Controla qual etapa está ativa (1, 2 ou 3)
var etapa_atual: int = 1

# Armazena o NOME do nó de destino ativo para onde as portas vão deslizar
var alvo_atual: String = "bolOr"


func _ready() -> void:
	vidas_atuais = vidas_maximas
	atualizar_interface_vidas()

	# Define o primeiro alvo da etapa 1
	alvo_atual = "bolOr"

	# Esconde a 2ª e a 3ª etapas no arranque
	esconder_ou_mostrar_no("proximocircuito", false)
	esconder_ou_mostrar_no("boliSeg", false)


func esconder_ou_mostrar_no(nome_no: String, visivel: bool) -> void:
	var no = find_child(nome_no, true, false)
	if no != null:
		no.visible = visivel


# ==========================================
# SISTEMA DE SOM (ACERTO E ERRO)
# ==========================================
func tocar_som(tipo: String) -> void:
	if tipo == "acerto":
		var som_acerto = find_child("SomAcerto", true, false)
		if som_acerto and som_acerto is AudioStreamPlayer:
			som_acerto.play()
	elif tipo == "erro":
		var som_erro = find_child("SomErro", true, false)
		if som_erro and som_erro is AudioStreamPlayer:
			som_erro.play()


func validar_jogada(porta_clicada) -> void:

	# ==================================================
	# ETAPA 1 (MANTIDA 100% IGUAL AO SEU CÓDIGO ORIGINAL)
	# ==================================================
	if etapa_atual == 1:

		if porta_clicada.tipo_porta == "OR":
			porta_clicada.encaixada = true
			tocar_som("acerto") # <--- Toca som de acerto
			etapa_atual = 2
			
			# Define o alvo para a 2ª etapa
			alvo_atual = "proximocircuito"
			
			# Revela o nó da 2ª etapa
			revelar_no("proximocircuito")
		else:
			processar_erro(porta_clicada)

	# ==================================================
	# ETAPA 2 (Alvo: "proximocircuito" | Resposta certa: NOT)
	# ==================================================
	elif etapa_atual == 2:

		# Checa se o tipo é "NOT" ou se o nó clicado se chama "not"
		var e_porta_not: bool = (porta_clicada.tipo_porta == "NOT") or (porta_clicada.name.to_lower() == "not")

		if e_porta_not:
			porta_clicada.encaixada = true
			tocar_som("acerto") # <--- Toca som de acerto
			etapa_atual = 0 # Circuito finalizado!
			alvo_atual = ""
			
			# Revela o nó da bolinha da saída (boliSeg)
			revelar_no("boliSeg")
			
			# Aguarda a iluminação da bolinha e exibe o painel de vitória
			await get_tree().create_timer(0.6).timeout
			exibir_painel_final("PARABÉNS! VOCÊ GANHOU!")
		else:
			processar_erro(porta_clicada)

	# ==================================================
	# ETAPA 3 (Reservada para próximos circuitos)
	# ==================================================
	elif etapa_atual == 3:

		if porta_clicada.tipo_porta == "AND":
			porta_clicada.encaixada = true
			tocar_som("acerto") # <--- Toca som de acerto
			etapa_atual = 0
			alvo_atual = ""
			exibir_painel_final("PARABÉNS! VOCÊ GANHOU!")
		else:
			processar_erro(porta_clicada)


func processar_erro(porta_clicada) -> void:
	tocar_som("erro") # <--- Toca som de erro
	porta_clicada.voltar_para_origem()
	vidas_atuais -= 1
	atualizar_interface_vidas()

	if vidas_atuais <= 0:
		game_over()


func atualizar_interface_vidas() -> void:
	var label_vidas = find_child("TextoVida", true, false)
	if label_vidas != null and label_vidas is Label:
		label_vidas.text = "x" + str(vidas_atuais)


func game_over() -> void:
	print("Game Over! Exibindo tela de derrota...")
	exibir_painel_final("VOCÊ PERDEU!")


func revelar_no(nome_no: String) -> void:
	var no = find_child(nome_no, true, false)

	if no != null:
		no.visible = true
		no.modulate.a = 0.0

		var tween = create_tween()
		tween.tween_property(
			no,
			"modulate:a",
			1.0,
			0.5
		)


# ==========================================
# PAINEL FINAL (VITÓRIA / GAME OVER)
# ==========================================
func exibir_painel_final(mensagem: String) -> void:
	# Camada por cima de todo o jogo
	var canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)

	# Fundo escurecido semi-transparente
	var fundo = ColorRect.new()
	fundo.color = Color(0, 0, 0, 0.65)
	fundo.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas_layer.add_child(fundo)

	# Caixa central do painel
	var painel = PanelContainer.new()
	painel.set_anchors_preset(Control.PRESET_CENTER)
	canvas_layer.add_child(painel)

	# Container vertical para organizar texto e botões
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 15)
	painel.add_child(vbox)

	# Texto (PARABÉNS! VOCÊ GANHOU! ou VOCÊ PERDEU!)
	var label = Label.new()
	label.text = mensagem
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(label)

	# Botão 1: Jogar Novamente
	var botao_reiniciar = Button.new()
	botao_reiniciar.text = "Jogar Novamente"
	botao_reiniciar.pressed.connect(func(): get_tree().reload_current_scene())
	vbox.add_child(botao_reiniciar)

	# Botão 2: Voltar (Pronto para conectar ao menu principal futuramente)
	var botao_voltar = Button.new()
	botao_voltar.text = "Voltar"
	botao_voltar.pressed.connect(_on_botao_voltar_pressionado)
	vbox.add_child(botao_voltar)


func _on_botao_voltar_pressionado() -> void:
	# Função pronta para redirecionar para o menu no futuro!
	print("Botão Voltar clicado! (Aguardando definição da tela de destino)")
