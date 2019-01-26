extends Node2D

export (String) var NAME = "Player1"
var is_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
    if name == "Player2":
        change_tower_start_position("Tower")
        change_status_start_position("Status")
        
        
func _process(delta):
    if is_playing == false:
        get_node("CardDeck").visible = false
      
      
func change_tower_start_position(nodeName):
    var node = get_node("Tower")
    var width = node.texture.get_width()
    var window_width = get_viewport().get_texture().get_width()
    node.position.x = window_width - node.position.x
    node.position.y = node.position.y


func change_status_start_position(nodeName):
    var node = get_node("Status")
    var image = node.get_node("StatusImage")
    var width = image.texture.get_width() * image.scale.x
    var window_width = get_viewport().get_texture().get_width()
    node.position.x = window_width - (node.position.x + width)
    node.position.y = node.position.y
    
    