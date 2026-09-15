extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_option_button_item_selected(index: int) -> void:
	print(index)
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
		1: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		
		2: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_option_button_resolucao_item_selected(index):
	match index:
		0:
			get_window().size = Vector2i(1280, 720)

		1:
			get_window().size = Vector2i(1366, 768)

		2:
			get_window().size = Vector2i(1600, 900)

		3:
			get_window().size = Vector2i(1920, 1080)

	print("Selecionado: ", index)


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(value / 100.0)
	)
	
