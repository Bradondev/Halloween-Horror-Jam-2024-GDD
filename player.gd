extends Control



signal  GameOver
signal Defended
signal Attacked
signal Turn(int)
var Health: int =0:
	set(value):
		Health = value
		if Health == 2:
			$"../UiAndEffect/1".visible = true
		if Health == 1:
			$"../UiAndEffect/1".visible = false
			$"../UiAndEffect/2".visible = true
@export var animation_player: AnimationPlayer 
@export var attack: AnimationPlayer
@export var animated_sprite_2d: AnimatedSprite2D 
@export var effects: AnimationPlayer 
@export var gasp: AudioStreamPlayer 
@export var parries: AudioStreamPlayer 


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
	PlaySound(parries,0,0)

	
	
func  Takedamage()->void:
	Health -= 1
	animation_player.play("Glitch")
	await  animation_player.animation_finished
	PlaySound(gasp,0,0)
	if Health <= 0:
		emit_signal("GameOver")
		print_debug("Player died")
func  PlaySound(AudioNode:AudioStreamPlayer, form: float , Stop: float = 0):
	AudioNode.play(form)
	if Stop:
		await  get_tree().create_timer(Stop).timeout
		AudioNode.stop()
