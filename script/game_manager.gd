extends Node

var coins = 0
var score = 0
var hasKey := false
var current_level: int = 0

@onready var jump_sound_player = $JumpSoundPlayer
@onready var magic_sound_player = $MagicSoundPlayer
@onready var death_sound_player = $DeathSoundPlayer
@onready var enemy_death_sound = $EnemyDeathSound
@onready var key_sound_player = $KeySoundPlayer
@onready var level_door_sound = $LevelDoorSoundPlayer
@export var prochaine_scene_path: String = "res://scenes/niveau_02.tscn"


signal cle_collectee
var cle_recuperee: bool = false

const KEY_COLLECT_STREAM = preload("res://assets/Sounds/Retro Success Melody 02 - choir soprano.wav")

func debloquer_cle(key_item):
	cle_collectee.emit(key_item)

const JUMP_STREAM = preload("res://assets/Sounds/Retro Jump Classic 08.wav")

const DOOR_STREAM = preload("res://assets/Sounds/Retro Event UI 01.wav")

func play_level_door_sound():
	playSFX(DOOR_STREAM)

func set_current_level(level_number: int) -> void:
	current_level = level_number
	print("GameManager: Niveau actuel mis à jour à : ", current_level)
	
func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	GameManager.play_level_door_sound()

	# --- NOUVELLE LOGIQUE CRITIQUE ---
	if GameManager.current_level == 4:
		print("level_door: Niveau 4 détecté. Tentative d'affichage du End Game Menu.")
		
		# On récupère le parent de la porte (qui devrait être la scène racine du niveau)
		var level_root = get_tree().current_scene 
		
		# On appelle une méthode dans le script de la scène du Niveau 4
		if level_root and level_root.has_method("display_end_menu"):
			level_root.display_end_menu()
		else:
			push_error("level_door: La scène Niveau 4 doit avoir la méthode 'display_end_menu' !")
	
	else:
		get_tree().change_scene_to_file(prochaine_scene_path)
		
func _process(delta: float) -> void:
	$"HUD/CoinsValue".text = str(coins)
	$"HUD/ScoreValue".text = str(score)

func playSFX(stream):
	$CoinsSoundPlayer.stream = stream
	$CoinsSoundPlayer.play()
	
func play_jump_sound():
	if jump_sound_player:
		jump_sound_player.play()

func play_magic_sound():
	if magic_sound_player and not magic_sound_player.is_playing():
		magic_sound_player.play()

func play_death_sound():
	if death_sound_player and not death_sound_player.is_playing():
		death_sound_player.play()
		
func play_enemy_death_sound():
	if enemy_death_sound and not enemy_death_sound.is_playing():
		enemy_death_sound.play()
		
func play_key_collect_sound():
	if key_sound_player:
		key_sound_player.stream = KEY_COLLECT_STREAM
		key_sound_player.play()
		
func play_level_door_sound_player():
	level_door_sound.stream = DOOR_STREAM
	level_door_sound.volume_db = 20
	level_door_sound.play()
	
