extends CanvasLayer

@onready var panel = $Panel
@onready var resume_button = $Panel/ResumeButton
@onready var options_button = $Panel/OptionsButton
@onready var options_panel = $Panel/OptionsPanel
@onready var options_close_button = $Panel/OptionsPanel/CloseButton
@onready var quitter_button = $Panel/QuitterButton



var is_paused: bool = false

func _ready() -> void:
	# Permet au menu de continuer à fonctionner même lorsque le jeu est en pause
	process_mode = Node.PROCESS_MODE_ALWAYS

	panel.visible = false

	resume_button.pressed.connect(_on_resume_pressed)
	options_button.pressed.connect(_on_options_pressed)
	options_close_button.pressed.connect(_on_options_close_pressed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"): # touche ESC
		toggle_pause()

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	
	if is_paused:
		panel.visible = true
		options_panel.visible = false
		resume_button.visible = true
		options_button.visible = true
		options_close_button.visible = true
	else:
		panel.visible = false
		options_panel.visible = false
	
	process_mode = Node.PROCESS_MODE_ALWAYS  # important pour continuer à recevoir les entrées
	
	
func _on_resume_pressed() -> void:
	if is_paused:
		toggle_pause()
		
func _on_options_pressed() -> void:
	# NE PAS cacher panel, il contient OptionsPanel
	options_panel.visible = true
	resume_button.visible = false
	options_button.visible = false
	quitter_button.visible = false

	

func _on_options_close_pressed() -> void:
	options_panel.visible = false
	resume_button.visible = true
	options_button.visible = true
	quitter_button.visible = true
