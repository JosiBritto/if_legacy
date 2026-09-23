extends Control
class_name ModalBloco

@export_category("ComposicaoModal")
@export var tutorial: Tutorial:
	set(value):
		tutorial = value;
		%DescricaoTutorialDesc.text = value.descricaoTutorial;
		%TituloTutotrialDescricao.text = value.tituloTutorial;
		%TutorialImagem.texture = value.image;
var _velocityText: float = 0.01;


func _ready() -> void:
	_initiateModal();

func _initiateModal() -> void:
	
	%DescricaoTutorialDesc.visible_characters = 0;
	while %DescricaoTutorialDesc.visible_ratio < 1:
			await get_tree().create_timer(_velocityText).timeout;
			%DescricaoTutorialDesc.visible_characters += 1;
			pass 

func _on_btn_sair_pressed() -> void:
	if %DescricaoTutorialDesc.visible_ratio == 1:
		queue_free();



func _on_btn_iniciar_pressed() -> void:
	queue_free();
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn");
