extends TextureRect

var Health:int =1
var CurrentIndex: int = 0
@export var ArrayOfScreen: Array[CanvasLayer]
var SwitchingScreen: bool = false
var  CurrentScreen: CanvasLayer 

var CurrentScreenIndex: int = 0
@export var base_screen: Node2D
@export var ListOfarms: Array[Texture2D]


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
	

	
	
	
	pass
