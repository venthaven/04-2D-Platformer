extends Node

onready var SM = get_parent()
onready var enemy = get_node("../..")

func _ready():
	yield(enemy, "ready")

func start():
	enemy.set_animation("Death")


func physics_process(_delta):
	if not enemy.animating:
		enemy.queue_free()
