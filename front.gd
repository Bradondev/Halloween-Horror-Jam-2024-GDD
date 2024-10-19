extends TextureRect

var FrontLargeEye: Control
var FrontMouth: Control
var Health:int =3
var Ticks:int = 10
@export var timer: Timer 


@export var base_screen: Node2D


func  CheckIfPlayerIsInSameView():
	if base_screen.CurrentScreen == get_parent():
		pass
	

func  CountDownTicks()->void:
	if base_screen.CurrentScreen == get_parent():return
	Ticks - 1
	if Ticks <= 0:
		MouthAttack()
		
		
		
func  ReadyMouthAttack():
	timer.start()
	pass
		
func MouthAttack():
	timer.stop()
	pass
		


func _on_timer_timeout() -> void:
	MouthAttack()
