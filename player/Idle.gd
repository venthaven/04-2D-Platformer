extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.velocity = Vector2(0,1.0)
	player.set_animation("Idle")

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if player.is_moving():
		SM.set_state("Moving")
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


