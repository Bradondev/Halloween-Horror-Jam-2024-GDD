extends Control

@export var Pages: Array[TextureRect]
@export var GameNode: Node
var CurrentPage: int = 0
# Called when the node enters the scene tree for the first time.
func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		NextPage()
		
func  NextPage():
	if CurrentPage >= Pages.size() - 1: 
		StartGame()
		return
	for Page in Pages:
		Page.hide()
	CurrentPage += 1
	Pages[CurrentPage].show()

func  StartGame (): 
	visible = false
	GameNode.process_mode = Node.PROCESS_MODE_INHERIT
	pass
	
	
	
	
	pass
	
	
