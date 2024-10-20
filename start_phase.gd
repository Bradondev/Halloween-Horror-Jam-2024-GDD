extends Control

@export var Pages: Array[TextureRect]
@export var GameNode: Node
@export var page_flip: AudioStreamPlayer 
var CurrentPage: int = 0
# Called whn the node enters the scene tree for the first time.
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
	PlaySound(page_flip,.1, .2)

func  StartGame (): 
	visible = false
	GameNode.process_mode = Node.PROCESS_MODE_INHERIT
	queue_free()
	pass
	


func  PlaySound(AudioNode:AudioStreamPlayer, form: float , Stop: float = 0):
	AudioNode.play(form)
	if Stop:
		await  get_tree().create_timer(Stop).timeout
		AudioNode.stop()
	
	pass
	
	
