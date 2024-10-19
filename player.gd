extends Control



signal Defended
signal Attacked
signal Turn(int)
var Health: int =0


enum PlayerStates{Attack,Deffense,Idle}


var  CurrentState = PlayerStates.Idle

func  _ready() -> void:
	Health = 3 




func  _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Left"):
		emit_signal("Turn",-1)

	if event.is_action_pressed("Right"):
		emit_signal("Turn",1)


		
func  Attack()->void:
	emit_signal("Attacked")
	
	pass
func  Defend()->void: 
	emit_signal("Attacked")
	pass
	
	
