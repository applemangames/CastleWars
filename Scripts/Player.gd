extends Node2D

export (String) var NAME = "Player1"
var is_playing = false
var is_human = true
var lock_cards = false


# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("NameActive").text = NAME
    get_node("NameDeactive").text = NAME
    move("Castle", float(find_node("TowerSize").text))
    move("Wall", float(find_node("WallSize").text))
    
    if name == "Player2":
        change_name_start_position("NameActive")
        change_name_start_position("NameDeactive")
        change_tower_start_position()
        change_wall_start_position()
        change_status_start_position()
        

func change_tower_start_position():
    var node = get_node("Castle")
    var width = node.texture.get_width()
    var window_width = get_viewport().get_texture().get_width()
    node.position.x = window_width - (node.position.x + (position.x*2))
    node.position.y = node.position.y


func change_wall_start_position():
    var node = get_node("Wall")
    var width = node.texture.get_width()
    var window_width = get_viewport().get_texture().get_width()
    node.position.x = window_width - (node.position.x + (position.x*2))
    node.position.y = node.position.y


func change_status_start_position():
    var node = get_node("Status")
    var image = node.get_node("StatusImage")
    var width = image.texture.get_width() * image.scale.x
    var window_width = get_viewport().get_texture().get_width()
    node.position.x = window_width - (node.position.x + width + (position.x*2))
    node.position.y = node.position.y
    
    
func change_name_start_position(node_name):
    var node = get_node(node_name)
    var width = node.rect_size.x 
    var window_width = get_viewport().get_texture().get_width()
    node.rect_position.x = window_width - (node.rect_position.x + width*node.rect_scale.x + (position.x*2))
    node.rect_position.y = node.rect_position.y


func active():
    get_node("NameActive").visible = true
    get_node("NameDeactive").visible = false
    
func deactive():
    get_node("NameActive").visible = false
    get_node("NameDeactive").visible = true


func move(type, value):
    self.get_node(type).position.y -= float(value) * get_cons(type)
    
  
func get_cons(type):
    if type == "Castle":
        return 2.0
    elif type == "Wall":
        return 3.0
    else:
        return 
    