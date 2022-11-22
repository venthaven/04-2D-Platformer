extends Node

onready var SM = get_parent()
onready var enemy = get_node("../..")

func _ready():
	yield(enemy, "ready")

func start():
	enemy.set_animation("Dodge")


func physics_process(_delta):
	if not enemy.animating:
		SM.set_state("Idle")
