extends KinematicBody2D

onready var SM = $StateMachine
var animating = false

var health = 20

func _ready():
	pass


func damage(d):
	health = health - d
	$Hitmark.text = str(d)
	$Hitmark.remove_color_override("font_color")
	if health <= 0:
		SM.set_state("Death")

func miss():
	$Hitmark.text = "MiSS"
	$Hitmark.add_color_override("font_color", Color(255,255,255,255))


func preempt():
	SM.set_state("Dodge")
	$Hitmark.text = ""

func gethit():
	SM.set_state("Hit")
	$Hitmark.text = ""

func set_animation(anim):
	animating = true
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()


func _on_AnimatedSprite_animation_finished():
		animating = false
