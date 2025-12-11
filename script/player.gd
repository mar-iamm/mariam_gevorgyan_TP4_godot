extends CharacterBody2D

@onready var camera_2d = $Camera2D

const SPEED = 1000.0
const JUMP_VELOCITY = -2000.0
const RESPAWN_POSITION = Vector2(100, 500)

signal key_collected(key_name)

var inventory := {}

func collect_key(key_name: String) -> void:
	inventory[key_name] = true
	key_collected.emit(key_name)

func has_key(key_name: String) -> bool:
	return inventory.get(key_name, false)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		GameManager.play_jump_sound()
		

	var run_multiplier = 1
	
	if Input.is_action_pressed("run"):
		run_multiplier = 2
	else:
		run_multiplier = 1
	
		
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED * run_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * run_multiplier)
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0: 
		$AnimatedSprite2D.flip_h = false
		
	if velocity.x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()
	
	if Input.is_action_just_pressed("magic"):
		GameManager.play_magic_sound()
		
		var magicNode = load("res://scenes/magic_area.tscn")
		var newMagic = magicNode.instantiate()

		if $AnimatedSprite2D.flip_h == false:
			newMagic.direction = -1
		else:
			newMagic.direction = 1
		newMagic.set_position(%MagicSpawnPoint.global_transform.origin)
		get_parent().add_child(newMagic)
		
	
func killPlayer():
		GameManager.play_death_sound()
		position = %Respawn.position
		$AnimatedSprite2D.flip_h = false
		respawn()
		
		
func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		killPlayer()
	
func respawn():
	if has_node("%Respawn"):
		global_position = %Respawn.global_position
	else:
		global_position = RESPAWN_POSITION
		
		velocity = Vector2.ZERO
		$AnimatedSprite2D.flip_h = false
		show()
		
