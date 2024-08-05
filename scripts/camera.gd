extends Camera2D

var speed = 400  # Скорость скроллинга камеры
var dragging = false
var last_mouse_position = Vector2()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				dragging = true
				last_mouse_position = event.position
			else:
				dragging = false

	if event is InputEventMouseMotion and dragging:
		var mouse_delta = event.position - last_mouse_position
		position -= mouse_delta
		last_mouse_position = event.position

func _process(delta):
	var input_vector = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1

	position += input_vector.normalized() * speed * delta
