extends Area2D

@onready var corps = $StaticBody2D
@onready var sprite = $Sprite2D  # adapte si ton sprite a un autre nom

func _ready() -> void:
	var game_manager = get_node("/root/GameManager")
	game_manager.connect("cle_collectee", Callable(self, "_on_cle_collectee"))

	# Si la clé a déjà été récupérée (par ex. après respawn)
	if game_manager.cle_recuperee:
		_on_cle_collectee()

func _on_cle_collectee() -> void:
	if corps and corps.is_inside_tree():
		corps.queue_free()  # supprime le StaticBody2D et donc la collision
	sprite.modulate = Color(1, 1, 1, 0.5)  # rend le sprite semi-transparent (porte ouverte)
