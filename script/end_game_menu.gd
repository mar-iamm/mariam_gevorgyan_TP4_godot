extends CanvasLayer

@onready var resume_button = $ResumeButton
@onready var label_button = $Label
@onready var quitter_button = $QuitterButton

const NIVEAU_1_PATH := "res://scenes/niveau_01.tscn" # vérifie que le chemin est bon

func _ready() -> void:
	# Le menu doit continuer à recevoir les entrées même quand le jeu est en pause
	process_mode = Node.PROCESS_MODE_ALWAYS

	visible = false
	resume_button.pressed.connect(_on_resume_pressed)
	# optionnel :
	# quitter_button.pressed.connect(_on_quit_pressed)

func show_end_game() -> void:
	print("show_end_game") # debug
	visible = true
	get_tree().paused = true    # pause du jeu pendant l’écran de fin

func _on_resume_pressed() -> void:
	print("resume pressed") # debug
	get_tree().paused = false
	get_tree().change_scene_to_file(NIVEAU_1_PATH)

# optionnel si tu veux utiliser QuitterButton
func _on_quit_pressed() -> void:
	get_tree().quit()
