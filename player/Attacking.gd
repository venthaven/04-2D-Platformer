extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Attack")
	randomize()

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if not player.animating:
		var hit = player.get_node("Attack/Hit")
		if hit.is_colliding():
			var enemy = hit.get_collider()
			if enemy.has_method("damage"):
				if player.hitsuccess == true:
					enemy.damage(randi() % (6)+player.damagemod)
				else:
					if enemy.has_method("miss"):
						enemy.miss()
				
		SM.set_state("Idle")
