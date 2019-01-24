extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type = ""
var price = ""
var player = 0


# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    
func get_width():
    return get_node("Front").texture.get_width() * get_node("Front").scale.x
    
func get_height():
    return get_node("Front").texture.get_height() * get_node("Front").scale.y



func _on_Button_pressed():
    var played = $"/root/Game/".find_node("Played")
    self.position = Vector2(0.0, 0.0)
    get_parent().remove_child(self)
    played.add_child(self)
    
    