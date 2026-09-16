extends Area2D

@export var item: Item:
	set(value):
		item = value;
		item.node = self;
		$Sprite2D.texture = value.icon;
		
var enable : bool = false:
	set(value): # controla a visibilidade da label
		enable = value;
		$Label.visible = value; 

func _ready() -> void:
	enable = false;
	name = item.title;
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and enable: # filtra que tipo de input é; se é ´ressionada e se enabel está ativo
		if event.keycode == KEY_E: # verifica se o keycode é "E"
			print(name + " activaded.");
			if item:
				item.activate();


func _on_body_entered(body: Node2D) -> void:
	enable = true;

func _on_body_exited(body: Node2D) -> void:
	enable = false;
	if item:
		item.de_activate();
