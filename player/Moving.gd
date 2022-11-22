extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

onready var prev_direction = player.direction

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Moving")
	player.jump_power = Vector2.ZERO

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	else:
		player.velocity.y = 0
	if player.is_moving():
		if player.direction != prev_direction:
			player.velocity.x = 0
			prev_direction = player.direction
		player.velocity += player.move_speed * player.move_vector()
		player.move_and_slide(player.velocity, Vector2.UP)
	else:
		player.velocity = Vector2.ZERO
		SM.set_state("Idle")
	if Input.is_action_pressed("attack"):
		var hit = player.get_node("Attack/Hit")
		if hit.is_colliding():
			var enemy = hit.get_collider()
			if enemy.has_method("damage"):
				var hitroll = randi() % (6)+1
				if hitroll >= player.tohit:
					player.hitsuccess = true
					if enemy.has_method("gethit"):
						enemy.gethit()
				else:
					player.hitsuccess = false
					if enemy.has_method("preempt"):
						enemy.preempt()
		SM.set_state("Attack")

