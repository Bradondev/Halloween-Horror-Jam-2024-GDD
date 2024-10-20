extends TextureRect

var FrontLargeEye: Control
var FrontMouth: Control
@export var player: Control 

var Ticks:int = 10
signal  EyeWasAttacked
signal GotParry
@export var shake_teeth: AnimationPlayer

@export var timer: Timer 
@export var attack_time: Timer 
@export var ParryArea: Area2D
@export var ArrayOfScreen: Array[CanvasLayer]
var SwitchingScreen: bool = false
var  CurrentScreen: Control

var CurrentScreenIndex: int = 0
@export var base_screen: CanvasLayer
@export var end: TextureRect 
@export var middle: TextureRect 
@export var ListOfMouths: Array[Texture2D]
@export var eye_1: Area2D 
@export var monster_maneger: Control 

@export var armsSound3: AudioStreamPlayer 
@export var squelching: AudioStreamPlayer
@export var lamb_chop_speed: AudioStreamPlayer 

var EyeIsOpend: bool
var IsAttacking: bool = false

func  _ready() -> void:
	CurrentScreen = get_parent()
	print_debug(CurrentScreen)
	CurrentScreenIndex = get_tree().get_nodes_in_group("Screen").find(get_parent())
	eye_1.monitoring = false
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
	
	
	

	
			

	
	
	pass



func  CheckIfPlayerIsInSameView():
	if base_screen.CurrentScreen == get_parent():
		pass
	

func  CountDownTicks(dir:int =0)->void:
	
	if base_screen.CurrentScreen == get_parent():return

	Ticks -= 1
	if Ticks <= 0:
		MouthAttack()
		print_debug("2")
	if IsAttacking: return
	if Ticks ==2:
		ReadyMouthAttack()
		print_debug("1")
		
	
	
	
	SetMouthSprite()
func  SetMouthSprite()->void:
	if Ticks >=7:
		texture = ListOfMouths[0]
	if Ticks ==6 or Ticks ==5:
		texture = ListOfMouths[1]
	if Ticks ==4 or Ticks ==3:
		texture = ListOfMouths[2]
		
	if  Ticks <=2 :
		texture = ListOfMouths[3]
		shake_teeth.play("Shaketeeth")
		return
	shake_teeth.stop()

		
func  ReadyMouthAttack():
	IsAttacking = true
	ParryArea.monitoring = true
	timer.start()	
	
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
		print_debug("attack went through")
		player.Takedamage()
	
	texture = ListOfMouths[0]
	
	Ticks = 10
	IsAttacking = false
	
	pass
	
func  MouthParryed():
	timer.stop()
	attack_time.stop()
	shake_teeth.stop()
	texture = ListOfMouths[4]
	
	eye_1.monitoring = true
	
	Ticks = 10
	IsAttacking = false
	SetMouthSprite()
	pass


func  Reset():
	eye_1.monitoring = false
	ParryArea.monitoring = false
	texture = ListOfMouths[0]
	IsAttacking = false
	Ticks = 10

func _on_timer_timeout() -> void:
	emit_signal("GotParry",false)





func _on_eye_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event.is_action_pressed("Attack")and eye_1.monitoring:
		if player.CurrentState == player.PlayerStates.Attack: return
		await player.Attack()
		Reset()
		monster_maneger.MoveMonster()
		end.RiseClaw(0)
		base_screen.EyesKilled +=1
		pass


func _on_parryed_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Defend") and IsAttacking:
		await player.Defend()
		emit_signal("GotParry",true)
		
		pass

func _on_attack_time_timeout() -> void:
	emit_signal("GotParry",false)
	pass # Replace with function body.
