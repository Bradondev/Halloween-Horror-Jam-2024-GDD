extends TextureRect


signal  EyeWasAttacked
var Health:int =1
var CurrentIndex: int = 0
@export var ArrayOfScreen: Array[CanvasLayer]
var SwitchingScreen: bool = false
var  CurrentScreen:Control
@export var armsSound3: AudioStreamPlayer 
@export var squelching: AudioStreamPlayer
@export var lamb_chop_speed: AudioStreamPlayer 
@export var white_noise: AudioStreamPlayer


var CurrentScreenIndex: int = 0
@export var base_screen: Node
@export var ListOfarms: Array[Texture2D]
@export var timer: Timer 
@export var attack_time: Timer 
@export var player: Control
@export var shake: AnimatedSprite2D 

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
	
	


signal GotParry



@export var ParryArea: Area2D

@export var end: TextureRect 
@export var middle: TextureRect 

@export var eye_1: Area2D 
@export var monster_maneger: Control 
var Ticks: int =0 

var EyeIsOpend: bool
var IsAttacking: bool = false

var BeenDef: bool = false




func  CheckIfPlayerIsInSameView():
	if base_screen.CurrentScreen == CurrentScreen:
		if Ticks >=3:
			white_noise.play()
		else :white_noise.stop()
		RiseClaw(1)
		pass
	

func  RiseClaw(dir:int =0)->void:
	
	

	Ticks += 1
	
	if Ticks >= 4: 
		Ticks = 0
	
	if Ticks ==3:
		PlaySound(armsSound3,7,2)
		if BeenDef:
			ReadyMouthAttack()
			shake.visible = true
		if !BeenDef:
			Ticks+=1
			ReadyMouthAttack()
			shake.visible = true
	
	
	SetMouthSprite()
func  SetMouthSprite()->void:
	texture = ListOfarms[Ticks]

		
		
		
func  ReadyMouthAttack():
	IsAttacking = true
	ParryArea.monitoring = true
	timer.start()	
	eye_1.monitoring = true
	var WasParryed = await GotParry
	
	if WasParryed: 
		MouthParryed()
	else:
		MouthAttack()
		return

	
		
func MouthAttack():
	timer.stop()
	attack_time.start()

	var WasParryed = await GotParry
	
	if WasParryed: 
		
		MouthParryed()
	else:
		print_debug("claw attack")
		player.Takedamage()
	
	texture = ListOfarms[0]
	Ticks = 0
	IsAttacking = false
	shake.visible = false
	pass
	
func  MouthParryed():
	timer.stop()
	attack_time.stop()
	texture = ListOfarms[0]
	shake.visible = false
	eye_1.monitoring = false
	
	Ticks = 0
	
	pass


func  Reset():
	eye_1.monitoring = false
	ParryArea.monitoring = false
	texture = ListOfarms[0]
	Ticks = 0

func _on_timer_timeout() -> void:
	emit_signal("GotParry",false)
	#MouthAttack()





func _on_eye_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event.is_action_pressed("Attack")and eye_1.monitoring:
		
	
		BeenDef = true
		await player.Attack()
		Reset()
		MouthParryed()
		monster_maneger.MoveMonster()
		PlaySound(squelching,0,0)
		PlaySound(lamb_chop_speed,7.5,4)
		base_screen.EyesKilled +=1
		print_debug("eye was attack")
		pass


func _on_parryed_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Defend") and IsAttacking:
		emit_signal("GotParry",true)
		Reset()
		await player.Defend()
		
		
	
		pass

func _on_attack_time_timeout() -> void:
	emit_signal("GotParry",false)
	pass # Replace with function body.


func  PlaySound(AudioNode:AudioStreamPlayer, form: float , Stop: float = 0):
	AudioNode.play(form)
	if Stop:
		await  get_tree().create_timer(Stop).timeout
		AudioNode.stop()
	
	pass

	
	
