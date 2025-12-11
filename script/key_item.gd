extends Area2D

@export var groupe_cle:String = "KeyItem"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_node("/root/GameManager").cle_recuperee = true
		get_node("/root/GameManager").emit_signal("cle_collectee")
		$Key.visible = false
		GameManager.playSFX(load("res://assets/Sounds/Retro Success Melody 02 - choir soprano.wav"))
		queue_free()
