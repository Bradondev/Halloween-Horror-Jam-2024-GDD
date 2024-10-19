extends Control
@export var front: TextureRect 
@export var middle: TextureRect 
@export var end: TextureRect 

@export var screen_1: CanvasLayer
@export var screen_2: CanvasLayer 
@export var sreen_3: CanvasLayer 
@export var screen_4: CanvasLayer


var MonsterMoving:bool = false



func  MoveMonster()->void:
	MonsterMoving = true
	if  front.CurrentScreen ==$"..".CurrentScreen:
		front.MoveBodyPart(1)
		end.MoveBodyPart(1)
		middle.MoveBodyPart(1)
	await get_tree().create_timer(.4).timeout
	if  middle.CurrentScreen ==$"..".CurrentScreen:
		front.MoveBodyPart(1)
		end.MoveBodyPart(1)
		middle.MoveBodyPart(1)
	await get_tree().create_timer(.4).timeout
	if  end.CurrentScreen ==$"..".CurrentScreen:
		front.MoveBodyPart(1)
		end.MoveBodyPart(1)
		middle.MoveBodyPart(1)
	await get_tree().create_timer(.4).timeout
	MonsterMoving = false


	
	
	
