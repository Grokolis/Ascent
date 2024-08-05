extends Control

var selected_avatar = ""
var selected_class = ""

func _ready():
	# Connect signals
	$PanelContainer/VBoxContainer/Button.connect("pressed", Callable(self, "_on_confirm_button_pressed"))
	$PanelContainer/VBoxContainer/MenuButton.get_popup().connect("id_pressed", Callable(self, "_on_class_selected"))
	$PanelContainer/VBoxContainer/HBoxContainer/Button.connect("pressed", Callable(self, "_on_avatar_button_pressed"))

	# Setup MenuButton for class selection
	var menu_button = $PanelContainer/VBoxContainer/MenuButton
	var popup = menu_button.get_popup()
	popup.add_item("Ancient", 0)
	popup.add_item("Ethereal", 1)
	popup.add_item("External", 2)

	# Hide the popup initially
	$PopupPanel.hide()

func _on_class_selected(id):
	var popup = $PanelContainer/VBoxContainer/MenuButton.get_popup()
	selected_class = popup.get_item_text(id)

func _on_avatar_button_pressed():
	_update_avatars()
	$PopupPanel.popup_centered()

func _update_avatars():
	var avatar_paths = []
	if selected_class == "Ancient":
		avatar_paths = [
			"res://art/avatars/ancient/female/f_elf_1.png",
			"res://art/avatars/ancient/female/f_elf_2.png",
			"res://art/avatars/ancient/female/f_human_1.png"
		]
	elif selected_class == "Ethereal":
		avatar_paths = [
			"res://art/avatars/ethereal/ethereal_1.png",
			"res://art/avatars/ethereal/ethereal_2.png",
		]
	elif selected_class == "External":
		avatar_paths = [
			"res://art/avatars/external/external_1.png",
			"res://art/avatars/external/external_2.png",
		]

	var grid = $PopupPanel/GridContainer
	for child in grid.get_children():
		grid.remove_child(child)
		child.queue_free()

	for path in avatar_paths:
		var button = TextureButton.new()
		button.texture_normal = load(path)
		button.connect("pressed", Callable(self, "_on_avatar_selected").bind([path]))
		grid.add_child(button)

func _on_avatar_selected(path):
	selected_avatar = path[0]
	print("Selected avatar: %s" % selected_avatar)
	$PopupPanel.hide()

	# Update the TextureRect with the selected avatar
	$PanelContainer/VBoxContainer/TextureRect.texture = load(selected_avatar)

func _on_confirm_button_pressed():
	var character_name = $PanelContainer/VBoxContainer/LineEdit.text
	if character_name.strip_edges() != "" and selected_avatar != "":
		print("Character name: %s" % character_name)
		print("Selected class: %s" % selected_class)
		print("Selected avatar: %s" % selected_avatar)
		_goto_main_scene()
	else:
		print("Please enter a valid character name and select an avatar")

func _goto_main_scene():
	get_tree().change_scene("res://scenes/MainScene.tscn")
