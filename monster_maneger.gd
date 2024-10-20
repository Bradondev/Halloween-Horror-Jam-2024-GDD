extends Control
@export var front: TextureRect 
@export var middle: TextureRect 
@export var end: TextureRect 

@export var screen_1: CanvasLayer
@export var screen_2: CanvasLayer 
@export var sreen_3: CanvasLayer 
@export var screen_4: CanvasLayer

@export var armsSound3: AudioStreamPlayer 
@export var squelching: AudioStreamPlayer
@export var lamb_chop_speed: AudioStreamPlayer 
@export var short_mic_wave_static: AudioStreamPlayer 

var MonsterMoving:bool = false



func  MoveMonster()->void:
	MonsterMoving = true
	PlaySound(short_mic_wave_static,0,0)
	if  front.CurrentScreen ==$"..".CurrentScreen:
		front.MoveBodyPart(1)
		end.MoveBodyPart(1)
		middle.MoveBodyPart(1)
	await get_tree().create_timer(.5).timeout
	if  middle.CurrentScreen ==$"..".CurrentScreen:
		front.MoveBodyPart(1)
		end.MoveBodyPart(1)
		middle.MoveBodyPart(1)
	await get_tree().create_timer(.5).timeout
	if  end.CurrentScreen ==$"..".CurrentScreen:
		front.MoveBodyPart(1)
		end.MoveBodyPart(1)
		middle.MoveBodyPart(1)
	await get_tree().create_timer(.5).timeout
	MonsterMoving = false


	
func  PlaySound(AudioNode:AudioStreamPlayer, form: float , Stop: float = 0):
	AudioNode.play(form)
	if Stop:
		await  get_tree().create_timer(Stop).timeout
		AudioNode.stop()
	
	
