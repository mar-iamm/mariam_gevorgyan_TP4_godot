extends Area2D

@export var prochaine_scene_path: String = "res://scenes/niveau_02.tscn"
@export var end_game_menu: CanvasLayer   # pour la porte finale, tu mets EndGameMenu ici

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	GameManager.play_level_door_sound()

	if end_game_menu:
		# PORTE FINALE (niveau 4) : on affiche le menu de fin
		end_game_menu.show_end_game()
	else:
		# PORTES NORMALES : on change de scène comme avant
		get_tree().change_scene_to_file(prochaine_scene_path)
