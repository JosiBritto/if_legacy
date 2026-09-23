extends Item
class_name Bloco


func activate():
	print(title + " activaded");
	ModalManagement.abrirBloco(self);

func de_activate():
	print(title + " de-ativaded");
	ModalManagement.deActivate(); 
