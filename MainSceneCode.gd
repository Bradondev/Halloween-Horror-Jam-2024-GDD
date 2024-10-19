extends Node2D
@export var screen_1: CanvasLayer
@export var screen_2: CanvasLayer 

@export var sreen_3: CanvasLayer 
@export var screen_4: CanvasLayer


var SwitchingScreen: bool = false


var  CurrentScreen: CanvasLayer 
var CurrentScreenIndex: int = 0


signal TurnDone
func  _ready() -> void:
	CurrentScreen = screen_1



		
		
		

		
func LookThroughScreenArrary(Dir:int)->void:
	if SwitchingScreen: return
	
	SwitchingScreen = true
	var NewTween : Tween = create_tween()
	CurrentScreen.get_node("ScreenShift").modulate = Color(1,1,1,0)
	NewTween.tween_property(CurrentScreen.get_node("ScreenShift"),"modulate",Color(1,1,1,1), .2)
	await NewTween.finished
	CurrentScreen.visible = false
	CurrentScreenIndex += Dir
	
	
	
	
	if CurrentScreenIndex > get_tree().get_nodes_in_group("Screen").size() -1:
		CurrentScreenIndex = 0
	if CurrentScreenIndex < 0 : 
		CurrentScreenIndex = get_tree().get_nodes_in_group("Screen").size() -1
	CurrentScreen = get_tree().get_nodes_in_group("Screen")[CurrentScreenIndex]
	NewTween = create_tween()
	CurrentScreen.visible = true	
	CurrentScreen.get_node("ScreenShift").modulate = Color(1,1,1,1)
	NewTween.tween_property(CurrentScreen.get_node("ScreenShift"),"modulate",Color(1,1,1,0), .2)
	await NewTween.finished
	
	SwitchingScreen = false
	emit_signal("TurnDone")
	
	
			

		
		
	pass
		
