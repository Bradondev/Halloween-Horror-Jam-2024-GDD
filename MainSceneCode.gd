extends CanvasLayer
@export var screen_1: Control
@export var screen_2: Control

@export var sreen_3: Control
@export var screen_4: Control

@export var armsSound3: AudioStreamPlayer 
@export var squelching: AudioStreamPlayer
@export var lamb_chop_speed: AudioStreamPlayer 
@export var short_mic_wave_static: AudioStreamPlayer 
var SwitchingScreen: bool = false




var EyesKilled: int = 0:
	set(value):
		EyesKilled = value
		if EyesKilled >=5:
			PlaySound(lamb_chop_speed,13,6)
			
			await get_tree().create_timer(3)
			WinGame()
			queue_free()
		


var  CurrentScreen: Control
var CurrentScreenIndex: int = 0
@export var end: TextureRect 
@export var effects: AnimationPlayer 


@export var GameOverScreen: Control
@export var WinScene: Control
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
	end.CheckIfPlayerIsInSameView()
	NewTween.tween_property(CurrentScreen.get_node("ScreenShift"),"modulate",Color(1,1,1,0), .2)
	await NewTween.finished
	
	SwitchingScreen = false
	
	emit_signal("TurnDone")	
			

		
		
	pass
		
func  WinGame():
	print_debug("won game")
	WinScene.process_mode = Node.PROCESS_MODE_INHERIT
	WinScene.visible = true
	
	
	pass
	

func _on_eye_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.

func  PlaySound(AudioNode:AudioStreamPlayer, form: float , Stop: float = 0):
	AudioNode.play(form)
	if Stop:
		await  get_tree().create_timer(Stop).timeout
		AudioNode.stop()
	
	pass

	
func _on_player_game_over() -> void:
	GameOverScreen.process_mode = Node.PROCESS_MODE_INHERIT
	GameOverScreen.visible  = true
	queue_free()
	process_mode = Node.PROCESS_MODE_DISABLED
	
	pass # Replace with function body.
