extends Node



var xp = 0

func xp_up():
	xp = xp+10
	if xp == 20:
		var player = get_node_or_null("/root/Game/Player_Container/Player")
		if player != null:
			player.levelup()
		else:
			print("rip")

func _unhandled_input(_event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
