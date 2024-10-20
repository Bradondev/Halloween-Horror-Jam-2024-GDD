extends TextureRect

var Health : int =3 
var CurrentIndex: int = 0
@export var base_screen: CanvasLayer
@export var monster_maneger: Control
@export var player: Control 

@export var eye_1HurtBox: Area2D
@export var eye_2HurtBox: Area2D 
@export var eye_3HurtBox: Area2D 
@export var eye_1_text: TextureRect 
@export var eye_2_text: TextureRect 
@export var eye_3_text: TextureRect 

@export var end: TextureRect 

@export var armsSound3: AudioStreamPlayer 
@export var squelching: AudioStreamPlayer
@export var lamb_chop_speed: AudioStreamPlayer 
@export var short_mic_wave_static: AudioStreamPlayer 

@export var ArrayOfScreen: Array[CanvasLayer]
# Called when the node enters the scene tree for the first time.

var SwitchingScreen: bool = false
var  CurrentScreen: Control

var CurrentScreenIndex: int = 0
signal  EyeWasAttacked

func  _ready() -> void:
	CurrentScreen = get_parent()
	CurrentScreenIndex = get_tree().get_nodes_in_group("Screen").find(get_parent())
func  MoveBodyPart(Dir:int)->void:
	if SwitchingScreen: return
	
	SwitchingScreen = true
	var NewTween : Tween = create_tween()

	NewTween.tween_property(self,"modulate",Color(1,1,1,0), .2)
	await NewTween.finished
	
	
	CurrentScreenIndex += Dir

	if CurrentScreenIndex > get_tree().get_nodes_in_group("Screen").size() -1:
		CurrentScreenIndex = 0
	if CurrentScreenIndex < 0 : 
		CurrentScreenIndex = get_tree().get_nodes_in_group("Screen").size() -1
	CurrentScreen = get_tree().get_nodes_in_group("Screen")[CurrentScreenIndex]
	reparent(get_tree().get_nodes_in_group("Screen")[CurrentScreenIndex])
	NewTween = create_tween()
	modulate = Color(1,1,1,1)
	NewTween.tween_property(self,"modulate",Color(1,1,1,1), .2)
	await NewTween.finished
	SwitchingScreen = false
	
	
	
func _on_eye_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if monster_maneger.MonsterMoving: return
	if event.is_action_pressed("Attack")and eye_1_text.visible:
		await player.Attack()
		PlaySound(squelching,0,0)
		PlaySound(lamb_chop_speed,7.5,4)
		monster_maneger.MoveMonster()
		eye_1_text.visible = false
		print_debug("eye 1 click")
		base_screen.EyesKilled +=1
		end.RiseClaw(0)
		
func _on_eye_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if monster_maneger.MonsterMoving: return
	if event.is_action_pressed("Attack") and eye_2_text.visible: 
		await player.Attack()
		PlaySound(squelching,0,0)
		PlaySound(lamb_chop_speed,7.5,4)
		monster_maneger.MoveMonster()
		end.RiseClaw(0)
		eye_2_text.visible = false
		base_screen.EyesKilled +=1
	pass # Replace with function body.


func _on_eye_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if monster_maneger.MonsterMoving: return
	if event.is_action_pressed("Attack")and eye_3_text.visible:
		await player.Attack()
		PlaySound(squelching,0,0)
		PlaySound(lamb_chop_speed,7.5,4)
		monster_maneger.MoveMonster()
		end.RiseClaw(0)
		base_screen.EyesKilled +=1
		eye_3_text.visible = false
	pass # Replace with function body.
	
func  PlaySound(AudioNode:AudioStreamPlayer, form: float , Stop: float = 0):
	AudioNode.play(form)
	if Stop:
		await  get_tree().create_timer(Stop).timeout
		AudioNode.stop()
	
	pass
