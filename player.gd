extends Control



signal Defended
signal Attacked
signal Turn(int)
var Health: int =0
@export var animation_player: AnimationPlayer 
@export var attack: AnimationPlayer
@export var animated_sprite_2d: AnimatedSprite2D 
@export var effects: AnimationPlayer 


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
	animated_sprite_2d.global_position = get_viewport().get_mouse_position()
	attack.play("Attack")
	await  attack.animation_finished
	effects.play("AttackFlash")
	

func  Defend()->void: 
	attack.play("Parry")
	await  attack.animation_finished
	effects.play("BlockFlash")

	
	
func  Takedamage()->void:
	Health -= 1
	animation_player.play("Glitch")
	if Health <= 0:
		print_debug("Player died")
	
