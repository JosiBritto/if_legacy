extends Control
class_name ModalBloco

@export_category("ComposicaoModal")
@export var descricaoTutorial : RichTextLabel;
@export var tituloTutorial: Label;
@export var imagemTutorial: TextureRect;
@export var imagemDescTemp: TextureRect;

var _velocityText: float = 0.01;

func _ready() -> void:
	_initiateModal();

func _initiateModal() -> void:
	
	descricaoTutorial.visible_characters = 0;
	while descricaoTutorial.visible_ratio < 1:
			await get_tree().create_timer(_velocityText).timeout;
			descricaoTutorial.visible_characters += 1;
			pass 

func _on_btn_sair_pressed() -> void:
	if descricaoTutorial.visible_ratio == 1:
		queue_free();

func _on_btn_iniciar_pressed() -> void:
	ModalManagement.changeScenary()
